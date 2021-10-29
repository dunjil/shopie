import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shopie/widgets/button_with_icon_lg.dart';
import '../apptheme/defaultTheme.dart';
import '../constants/color_constants.dart';
import '../constants/style_constants.dart';
import 'login_screen.dart';
import '../constants/input_constants.dart';
import 'package:http/http.dart' as _http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessAccountSignUpScreen extends StatefulWidget {
  @override
  _BusinessAccountSignUpScreenState createState() =>
      _BusinessAccountSignUpScreenState();
}

Future saveRegisteredPreferences(bool registered, String businessId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("registered", registered);
  prefs.setString("business_id", businessId);
  return prefs;
}

class _BusinessAccountSignUpScreenState
    extends State<BusinessAccountSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _getCategoriesList();
    _getTownsList();
    _hidePassword = true;
    _hideRpassword = true;
    _isLoading = false;
  }

  bool _hidePassword;
  bool _hideRpassword;
  hideUnhidePassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  hideUnhideRPassword() {
    setState(() {
      _hideRpassword = !_hideRpassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Container(
          color: kPrimaryColor,
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
                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.06,
                  //   alignment: Alignment.center,
                  //   child: Image.asset(kShopieLogo3),
                  // ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.01,
                  // ),
                  TextFormField(
                    controller: _businessName,
                    style: kTextFieldStyle,
                    cursorColor: Colors.white,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Business Name", labelStyle: kBodyTextStyle),
                    validator: (String text) {
                      if (text.length < 3) {
                        return "Please provide a valid Business Name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: an(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            focusColor: Colors.white,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: primaryColor,
                              ),
                              child: DropdownButton(
                                value: _category,
                                hint: Text(
                                  "Business Category",
                                  style: kBodyTextStyle,
                                ),
                                iconEnabledColor: Colors.white,
                                iconDisabledColor: Colors.white,
                                style: kBodyTextStyle.copyWith(
                                    color: kSecondColor),
                                items: _categories?.map((cat) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          cat,
                                          style: kBodyTextStyle,
                                        ),
                                        value: cat.toString(),
                                      );
                                    })?.toList() ??
                                    [],
                                onChanged: (item) {
                                  setState(() {
                                    _category = item;
                                    _getSubCategoriesList();
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
                    color: Colors.white,
                    thickness: 1,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: primaryColor,
                              ),
                              child: DropdownButton(
                                value: _subcategory,
                                hint: Text(
                                  "Select Subcategory",
                                  style: kBodyTextStyle,
                                ),
                                iconEnabledColor: Colors.white,
                                iconDisabledColor: Colors.white,
                                style: kBodyTextStyle,
                                items: _subCategories?.map((scat) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          scat,
                                          style: kBodyTextStyle,
                                        ),
                                        value: scat.toString(),
                                      );
                                    })?.toList() ??
                                    [],
                                onChanged: (item) {
                                  setState(() {
                                    _subcategory = item;
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
                    color: Colors.white,
                    thickness: 1,
                  ),
                  TextFormField(
                    controller: _phoneNumber,
                    style: kTextFieldStyle,
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.white,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Phone Number", labelStyle: kBodyTextStyle),
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
                    style: kTextFieldStyle,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.white,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Email", labelStyle: kBodyTextStyle),
                    validator: (String text) {
                      return validateEmail(text);
                    },
                  ),
                  TextFormField(
                    controller: _address,
                    style: kTextFieldStyle,
                    cursorColor: Colors.white,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Address", labelStyle: kBodyTextStyle),
                    validator: (String text) {
                      if (text.length < 1) {
                        return "You address is very important to us";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                        controller: _town,
                        cursorColor: Colors.white,
                        style: kBodyTextStyle,
                        decoration: kTextFieldDecoration.copyWith(
                            labelText: "Town", labelStyle: kBodyTextStyle)),
                    suggestionsCallback: (pattern) async {
                      if (pattern == "" || pattern == null) {
                        var data = await _getTownsList();
                        return data;
                      } else {
                        dynamic data = await _searchTown(pattern);
                        return data;
                      }
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(
                          suggestion,
                          style: kBodyTextStyle.copyWith(color: primaryColor),
                        ),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        _town.text = suggestion;
                      });
                    },
                  ),
                  TextFormField(
                    controller: _password,
                    style: kTextFieldStyle,
                    obscureText: _hidePassword,
                    cursorColor: Colors.white,
                    decoration: kTextFieldDecoration.copyWith(
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
                        labelStyle: kBodyTextStyle),
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
                  TextFormField(
                    controller: _verifyPassword,
                    style: kTextFieldStyle,
                    obscureText: _hideRpassword,
                    cursorColor: Colors.white,
                    decoration: kTextFieldDecoration.copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _hideRpassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: hideUnhideRPassword,
                        ),
                        labelText: "Repeat Password",
                        labelStyle: kBodyTextStyle),
                    validator: (String text) {
                      if (text != _password.text) {
                        return "Must match";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      _verifyPassword.text = val;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  CreateButtonWithIconLg(
                    title: "Create Business Account",
                    onPressed: () {
                      _formValidator();
                    },
                    assetLocation: "assets/img/database.png",
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

  List _categories;
  String _category;

  List _subCategories;
  String _subcategory;

  Future _getCategoriesList() async {
    await _http.post(kCategoryUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }).then((response) {
      var data = json.decode(response.body);
      setState(() {
        _categories = data["categories"];
      });
    });
  }

  Future _searchTown(String text) async {
    _http.Response res = await _http.get(
      kSearchTownsUrl + "?data=$text",
      headers: {'Content-Type': 'application/json'},
    );
    var data = json.decode(res.body);
    return data['towns'];
  }

  Future _getSubCategoriesList() async {
    await _http.post(
      kSubCategoriesUrl,
      body: {"category": _category},
    ).then((response) {
      var data = json.decode(response.body);
      setState(() {
        _subCategories = data["sub_categories"];
      });
    });
  }

  Future _getTownsList() async {
    _http.Response res = await _http.post(
      kTownsUrl,
      headers: {'Content-Type': 'application/json'},
    );
    var data = json.decode(res.body);
    return data['towns'];
  }

  TextEditingController _businessName = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _verifyPassword = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _emailAddress = TextEditingController();
  TextEditingController _town = TextEditingController();
  TextEditingController _address = TextEditingController();

  _formValidator() {
    if (_formKey.currentState.validate()) {
      _signUpUser();
    } else if (_password.text != _verifyPassword.text) {
      Alert(
        style: kAlertStyle,
        context: context,
        type: AlertType.warning,
        title: "Password Mismatch",
        desc: "Please ensure the two password fields are the same",
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
    } else {
      print("Unexplained Error");
    }
  }

  _signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _http.Response response = await _http.post(kCreateShopUrl, headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }, body: {
        "business_name": _businessName.text,
        "category": _category,
        "sub_category": _subcategory,
        "phone": _phoneNumber.text,
        "email": _emailAddress.text,
        "address": _address.text,
        "town": _town.text,
        "password": _password.text,
      });
      setState(() {
        _isLoading = false;
      });
      print(response.body);
      var data = json.decode(response.body);
      String status = data["status"];
      String businessId = data["business_id"];
      if (status == "exists") {
        await saveRegisteredPreferences(true, businessId);
        Alert(
          style: kAlertStyle,
          context: context,
          type: AlertType.warning,
          title: "Account Exists",
          desc:
              "You already have an account with us.\nYou can add more businesses to your account when you log into your account.",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: tm * 3.3),
              ),
              onPressed: () {
                Navigator.pop(context);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
              color: kSecondColor,
            ),
          ],
        ).show();
      } else if (status == "error") {
        Alert(
          style: kAlertStyle,
          context: context,
          type: AlertType.error,
          title: "Error",
          desc:
              "Error Encountered while creating your business account.\nEnsure you have an active internet connection",
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
      } else if (status == "success") {
        String businessId = data["business_id"];
        await saveRegisteredPreferences(true, businessId);
        Alert(
          style: kAlertStyle,
          context: context,
          type: AlertType.success,
          title: "SUCCESS",
          desc:
              "You have successfully created a business account\n \n Your Account ID is $businessId. Take note of your Account ID and keep it safe",
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
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
            "Error Encountered while creating your business account.\n Please ensure you have an active internet connection\n ${e.toString()}",
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
