import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shopie/models/staff_model.dart';
import '../constants/input_constants.dart';
import '../constants/color_constants.dart';
import '../constants/style_constants.dart';
import '../widgets/button_with_icon_sm.dart';
import 'package:http/http.dart' as _http;
import 'dart:convert';
import 'splashscreen.dart';

class AdminOpeningBalance extends StatefulWidget {
  @override
  _AdminOpeningBalanceState createState() => _AdminOpeningBalanceState();
}

class _AdminOpeningBalanceState extends State<AdminOpeningBalance> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _isLoading = false;
  Staff staffModel = Staff();

  TextEditingController _amount = TextEditingController();
  String productId;
  Staff _selectedStaff;
  String _selectedStaffName;
  List<Staff> staffList = [];

  @override
  initState() {
    super.initState();
    _getStaffList();
  }

  Future _getStaffList() async {
    await _http.post(kGetAccountsUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "business_id": businessId,
    }).then((response) {
      var result = json.decode(response.body);
      List listData = result["data"];
      String status = result["status"];
      List<Staff> listOfStaff = [];
      print("The List of Staff is " + response.body);
      if (listData.length > 0) {
        listData.forEach((data) {
          listOfStaff.add(Staff.fromJson(data));
        });
        setState(() {
          staffList = listOfStaff;
        });
      }
    });
  }

  clearInputFields() {
    setState(() {
      _amount.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Set Opening Balance"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: im * 0.5, horizontal: im * 5.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            focusColor: Colors.white,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: kHomePanelColor,
                              ),
                              child: DropdownButton(
                                value: _selectedStaffName,
                                hint: Text(
                                  "Staff",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: tm * 2.0),
                                ),
                                iconEnabledColor: kPrimaryColor,
                                iconDisabledColor: kPrimaryColor,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 2.0 * tm,
                                ),
                                items: staffList.map((staf) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          staf.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: tm * 2.0),
                                        ),
                                        value: staf.name,
                                      );
                                    })?.toList() ??
                                    [],
                                onChanged: (item) {
                                  setState(() {
                                    _selectedStaffName = item.toString();
                                    _selectedStaff = staffList[
                                        staffList.indexWhere((stf) =>
                                            stf.name.startsWith(item))];
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: kPrimaryColor,
                    thickness: 1,
                  ),
                  TextFormField(
                    controller: _amount,
                    keyboardType: TextInputType.number,
                    style: kTextFieldStyle.copyWith(color: Colors.black),
                    cursorColor: kPrimaryColor,
                    decoration: k2TextFieldDecoration.copyWith(
                      labelText: "Amount",
                      labelStyle: GoogleFonts.roboto(
                          color: kPrimaryColor, fontSize: tm * 2.0),
                    ),
                    validator: (String text) {
                      if (text.isEmpty) {
                        return "Please provide a valid amount";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  CreateButtonWithIconSm(
                    title: "Continue",
                    onPressed: () {
                      if (staffList.length < 1) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: Text(
                                  "Your have no staff in this account.\n Please Create a staff first",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Icon(Icons.error_outline,
                                    color: Colors.red),
                              )
                            ],
                          ),
                          duration: Duration(seconds: 3),
                        ));
                      } else {
                        _setOpeningBalance();
                      }
                    },
                    assetLocation: "assets/img/cash_in_hand.png",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _setOpeningBalance() async {
    if (_formKey.currentState.validate() && _selectedStaff.email != null) {
      setState(() {
        _isLoading = true;
      });
      try {
        _http.Response response =
            await _http.post(kSetOpeningBalanceUrl, headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        }, body: {
          "business_id": businessId,
          "staff": _selectedStaff.email,
          "amount": _amount.text,
          "paid_by": staff,
        });
        // var data = json.decode(response.body);
        String status = response.body;
        if (status == "found") {
          setState(() {
            _isLoading = false;
          });
          Alert(
            style: kAlertStyle,
            context: context,
            type: AlertType.error,
            imageHeight: hm * 4.5,
            imageWidth: im * 6.5,
            title: "Found",
            desc: "This staff already has an opening balance",
            buttons: [
              DialogButton(
                child: Text(
                  "Ok",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.pop(context),
                color: Colors.transparent,
              ),
            ],
          ).show();
        } else if (status == "error") {
          setState(() {
            _isLoading = false;
          });
          Alert(
            style: kAlertStyle,
            context: context,
            type: AlertType.error,
            imageHeight: hm * 4.5,
            imageWidth: im * 6.5,
            title: "Error",
            desc: "Check your internet connection",
            buttons: [
              DialogButton(
                child: Text(
                  "cancel",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.pop(context),
                color: Colors.transparent,
              ),
            ],
          ).show();
        } else if (status == "success") {
          setState(() {
            _isLoading = false;
          });
          Alert(
            style: kAlertStyle,
            context: context,
            type: AlertType.success,
            imageHeight: hm * 4.5,
            imageWidth: im * 6.5,
            title: "Success",
            desc: "Opening Balance Successfully Set",
            buttons: [
              DialogButton(
                child: Text(
                  "OK",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.transparent,
              ),
            ],
          ).show();
        }
        clearInputFields();
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print(e.toString());
        Alert(
          style: kAlertStyle,
          context: context,
          type: AlertType.error,
          imageHeight: hm * 4.5,
          imageWidth: im * 6.5,
          title: "Error",
          desc: "Oops! An Error Occurred\n ${e.toString()}",
          buttons: [
            DialogButton(
              child: Text(
                "cancel",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.transparent,
            ),
          ],
        ).show();
      }
    }
  }
}
