import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/color_constants.dart';
import '../constants/style_constants.dart';
import 'login_screen.dart';
import '../widgets/button_with_icon_sm.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as _http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';
import '../constants/input_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectBusinessScreen extends StatefulWidget {
  @override
  _ConnectBusinessScreenState createState() => _ConnectBusinessScreenState();
}

Future saveRegisteredPreferences(String businessId, bool registered) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("business_id", businessId);
  prefs.setBool("registered", registered);
  return prefs;
}

class _ConnectBusinessScreenState extends State<ConnectBusinessScreen> {
  String _bizId;
  bool _isLoading;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController businessIdController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        height: height * 1,
        decoration: BoxDecoration(
          color: kPrimaryColor,
        ),
        child: Center(
          child: _isLoading
              ? Theme(
                  data: Theme.of(context).copyWith(
                    accentColor: kSecondColor,
                  ),
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: businessIdController,
                        validator: (String val) {
                          if (val == null || val.trim() == "") {
                            return "Please enter a valid business Id";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white70,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          _bizId = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter Your Business ID',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      CreateButtonWithIconSm(
                        title: "Proceed",
                        assetLocation: "assets/img/ok.png",
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _verifyBusinessId(_bizId, context);
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.08,
                      ),
                      CreateButtonWithIconSm(
                        title: "Use Qr Code",
                        assetLocation: "assets/img/qrcode.png",
                        onPressed: () async {
                          await scanQR().then((code) async {
                            _verifyBusinessId(code, context);
                          });
                        },
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future scanQR() async {
    String barcode = await scanner.scan();
    print("This is the code $barcode");
    return barcode;
  }

  _verifyBusinessId(String businessID, context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      _http.Response response = await _http.post(
        kVerifyBusinessIdUrl,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          "business_id": businessID,
        },
      );
      print(response.body);
      var data = jsonDecode(response.body);
      print(response.body);
      String status = data["status"].toString();
      setState(() {
        _isLoading = false;
      });
      if (status == "found") {
        await saveRegisteredPreferences(businessID, true);
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Container(
            decoration: BoxDecoration(
              color: kSecondColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Text(
                "Business Connected Successfully",
                style: TextStyle(color: kPrimaryColor, fontSize: tm * 2.0),
              ),
            ),
          ),
          duration: Duration(seconds: 3),
        ));
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) {
            return LoginScreen();
          }),
        );
      } else if (status == "not found") {
        Alert(
          style: kAlertStyle,
          context: context,
          type: AlertType.error,
          title: "Error",
          desc: "Invalid ID",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: kSecondColor,
            ),
          ],
        ).show();
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Alert(
        style: kAlertStyle,
        context: context,
        type: AlertType.error,
        title: "Error",
        desc:
            "Error\n Please ensure you have an active internet connection\n ${e.toString()}",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: kSecondColor,
          ),
        ],
      ).show();
    }
  }
}
