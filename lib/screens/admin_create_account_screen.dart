import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shopie/widgets/button_with_icon_lg.dart';
import 'package:shopie/widgets/button_with_icon_sm.dart';
import '../constants/color_constants.dart';
import '../constants/style_constants.dart';
import '../constants/input_constants.dart';
import 'package:http/http.dart' as _http;
import 'package:rflutter_alert/rflutter_alert.dart';

import 'splashscreen.dart';

class AdminCreateAccount extends StatefulWidget {
  @override
  _AdminCreateAccountState createState() => _AdminCreateAccountState();
}

class _AdminCreateAccountState extends State<AdminCreateAccount> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _hidePassword = true;
    _isLoading = false;
  }

  bool _hidePassword;
  hideUnhidePassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 3.0 * im, right: 3.0 * im),
            child: Form(
              key: _formKey,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
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
                                value: _accountType,
                                hint: Text(
                                  "Account Type",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: tm * 2.0),
                                ),
                                iconEnabledColor: kPrimaryColor,
                                iconDisabledColor: kPrimaryColor,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 2.0 * tm,
                                ),
                                items: _accountTypes?.map((cat) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          cat,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: tm * 2.0),
                                        ),
                                        value: cat.toString(),
                                      );
                                    })?.toList() ??
                                    [],
                                onChanged: (item) {
                                  setState(() {
                                    _accountType = item;
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
                    controller: _name,
                    style: kTextFieldStyle.copyWith(color: Colors.black),
                    cursorColor: kPrimaryColor,
                    decoration: k2TextFieldDecoration.copyWith(
                      labelText: "Name",
                      labelStyle: GoogleFonts.roboto(
                          color: kPrimaryColor, fontSize: tm * 2.0),
                    ),
                    validator: (String text) {
                      if (text.length < 3) {
                        return "Please provide a valid Name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _phoneNumber,
                    style: kTextFieldStyle.copyWith(color: Colors.black),
                    keyboardType: TextInputType.phone,
                    cursorColor: kPrimaryColor,
                    decoration: k2TextFieldDecoration.copyWith(
                      labelText: "Phone Number",
                      labelStyle: GoogleFonts.roboto(
                          color: kPrimaryColor, fontSize: tm * 2.0),
                    ),
                    validator: (String text) {
                      if (text == null) {
                        return "Phone number is required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _emailAddress,
                    style: kTextFieldStyle.copyWith(color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: kPrimaryColor,
                    decoration: k2TextFieldDecoration.copyWith(
                      labelText: "Email",
                      labelStyle: GoogleFonts.roboto(
                          color: kPrimaryColor, fontSize: tm * 2.0),
                    ),
                    validator: (String text) {
                      return validateEmail(text);
                    },
                  ),
                  TextFormField(
                    controller: _address,
                    style: kTextFieldStyle.copyWith(color: Colors.black),
                    cursorColor: kPrimaryColor,
                    decoration: k2TextFieldDecoration.copyWith(
                      labelText: "Address(Optional)",
                      labelStyle: GoogleFonts.roboto(
                          color: kPrimaryColor, fontSize: tm * 2.0),
                    ),
                  ),
                  TextFormField(
                    controller: _password,
                    style: kTextFieldStyle.copyWith(color: Colors.black),
                    obscureText: _hidePassword,
                    cursorColor: kPrimaryColor,
                    decoration: k2TextFieldDecoration.copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: hideUnhidePassword,
                      ),
                      labelText: "Password",
                      labelStyle: GoogleFonts.roboto(
                          color: kPrimaryColor, fontSize: tm * 2.0),
                    ),
                    validator: (String text) {
                      if (text.length < 7) {
                        return "Password must be greater than 6";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      _password.text = val;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  CreateButtonWithIconSm(
                    title: "Create Account",
                    onPressed: () {
                      _formValidator();
                    },
                    assetLocation: "assets/img/administrator.png",
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

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  String validateMobile(String value) {
    if (value.length != 11)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  List _accountTypes = ["Admin", "Cashier"];
  String _accountType;
  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _emailAddress = TextEditingController();
  TextEditingController _address = TextEditingController();

  _formValidator() {
    if (_formKey.currentState.validate()) {
      _createAccount();
    }
  }

  _clearFields() {
    setState(() {
      _name.clear();
      _phoneNumber.clear();
      _emailAddress.clear();
      _address.clear();
      _password.clear();
    });
  }

  _createAccount() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _http.Response response = await _http.post(kCreateAccountUrl, headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }, body: {
        "business_id": businessId,
        "account_type": _accountType,
        "name": _name.text,
        "phone": _phoneNumber.text,
        "email": _emailAddress.text,
        "address": _address.text,
        "password": _password.text,
        "staff": staff,
      });
      setState(() {
        _isLoading = false;
      });
      // var data = json.decode(response.body);
      String status = response.body;
      if (status == "found") {
        Alert(
          style: kAlertStyle,
          context: context,
          type: AlertType.warning,
          imageHeight: hm * 4.5,
          imageWidth: im * 6.5,
          title: "Account Exists",
          desc: "Sorry, A user with this email already exists.",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: tm * 3.3,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.transparent,
            ),
          ],
        ).show();
      } else if (status == "error") {
        Alert(
          style: kAlertStyle,
          context: context,
          type: AlertType.error,
          imageHeight: hm * 4.5,
          imageWidth: im * 6.5,
          title: "Error",
          desc:
              "Error Encountered while creating  account.\nCheck internet connection",
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
        _clearFields();
        Alert(
          style: kAlertStyle,
          context: context,
          type: AlertType.success,
          imageHeight: hm * 4.5,
          imageWidth: im * 6.5,
          title: "SUCCESS",
          desc: "You have successfully created an account",
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
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Alert(
        style: kAlertStyle,
        context: context,
        imageHeight: hm * 4.5,
        imageWidth: im * 6.5,
        type: AlertType.error,
        title: "Error",
        desc:
            "Error Encountered while creating account.\n Please ensure you have an active internet connection\n ${e.toString()}",
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
