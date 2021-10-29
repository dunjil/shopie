import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopie/widgets/button_with_icon_sm.dart';
import '../constants/color_constants.dart';
import '../constants/input_constants.dart';
import '../constants/logo_icon_constants.dart';
import '../constants/style_constants.dart';
import 'package:http/http.dart' as _http;
import 'home_screen.dart';
import 'select_module_screen.dart';
import '../utils/size_config.dart';

import 'splashscreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

Future saveRegisteredPreferences(String email, bool rememberMe) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("staff", email);
  prefs.setBool("remember_me", rememberMe);
  return prefs;
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool _hidePassword;
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe;
  bool _isLoading;
  @override
  void initState() {
    super.initState();
    _hidePassword = true;
    loadBusinessIdPreferences();
    _rememberMe = false;
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    double tm = SizeConfig.textMultiplier;
    double hm = SizeConfig.heightMultiplier;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: kPrimaryColor,
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(left: 2.0, right: 2.0, top: hm * 18),
              child: ModalProgressHUD(
                inAsyncCall: _isLoading,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      kShopieLogo2,
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    TextFormField(
                      controller: emailController,
                      style: kTextFieldStyle,
                      cursorColor: Colors.white,
                      decoration: kTextFieldDecoration.copyWith(
                        labelText: "Email",
                        labelStyle: kTextFieldStyle,
                      ),
                      validator: (String text) {
                        if (text.length < 1) {
                          return "Please provide a valid email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _hidePassword,
                      style: kTextFieldStyle,
                      cursorColor: Colors.white,
                      decoration: kTextFieldDecoration.copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: kSecondColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                        ),
                        labelText: "Password",
                        labelStyle: kTextFieldStyle,
                      ),
                      validator: (String text) {
                        if (text.length < 1) {
                          return "Password field is required";
                        } else {
                          return null;
                        }
                      },
                    ),
                    ListTileTheme(
                      style: ListTileStyle.list,
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      child: Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: CheckboxListTile(
                          activeColor: kSecondColor,
                          checkColor: Colors.white,
                          title: Text(
                            "Remember me",
                            style: TextStyle(
                                color: Colors.white, fontSize: tm * 2.0),
                          ),
                          value: _rememberMe,
                          onChanged: (newValue) {
                            setState(() {
                              _rememberMe = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.008,
                    ),
                    MaterialButton(
                      onPressed: _validateForm,
                      child: Container(
                        height: hm * 8,
                        width: im * 120,
                        decoration: BoxDecoration(
                          color: kSecondColor,
                          borderRadius: BorderRadius.circular(im * 15),
                        ),
                        child: Center(
                          child: Padding(
                              padding: EdgeInsets.only(
                                top: 6.0,
                                bottom: 6.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image: AssetImage(
                                      "assets/img/loginicon.png",
                                    ),
                                    height: 8.8 * im,
                                    width: 8.8 * im,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  Text(
                                    "  Login",
                                    style: GoogleFonts.roboto(
                                        color: kPrimaryColor,
                                        fontSize: 2.3 * tm,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          color: Colors.transparent,
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.white, fontSize: tm * 2.0),
                          ),
                        ),
                        FlatButton(
                          color: Colors.transparent,
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SelectModuleScreen()));
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.white, fontSize: tm * 2.0),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _validateForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _loginUser();
    }
  }

  _loginUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _http.Response response = await _http.post(
        kShopLoginUrl,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          "email": emailController.text,
          "password": passwordController.text
        },
      );
      var data = jsonDecode(response.body);
      String status = data["status"].toString();
      String access = data["access"].toString();
      setState(() {
        _isLoading = false;
      });
      if (status == "success") {
        staff = emailController.text;
        if (_rememberMe) {
          await saveRegisteredPreferences(emailController.text, _rememberMe);
        }
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(),
          ),
        );
      } else if (status == "not found") {
        Alert(
          style: kAlertStyle,
          context: context,
          type: AlertType.error,
          btnTextSize: tm * 2.5,
          imageHeight: hm * 2.8,
          imageWidth: im * 4.8,
          title: "Error",
          desc: "Account not found",
          buttons: [
            DialogButton(
              child: Text(
                "cancel",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: tm * 2.6,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.transparent,
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
        btnTextSize: tm * 2.5,
        imageHeight: hm * 2.5,
        imageWidth: im * 4.5,
        title: "Error",
        desc:
            "Sign in Error account.\n Please ensure you have an active internet connection\n ${e.toString()}",
        buttons: [
          DialogButton(
            child: Text(
              "cancel",
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
