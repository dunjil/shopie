import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shopie/utils/size_config.dart';
import 'color_constants.dart';

double tm = SizeConfig.textMultiplier;
double im = SizeConfig.imageSizeMultiplier;
double hm = SizeConfig.heightMultiplier;

final kTextFieldDecoration = InputDecoration(
  hasFloatingPlaceholder: true,
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white70),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white70),
  ),
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white70),
  ),
  labelStyle: TextStyle(
    color: Colors.white,
    fontSize: tm * 2.0,
  ),
  hintStyle: TextStyle(
    color: Colors.white,
    fontSize: tm * 2.0,
  ),
);
final k2TextFieldDecoration = InputDecoration(
  floatingLabelBehavior: true,
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor),
  ),
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor),
  ),
);
final kTextFieldStyle = TextStyle(
  color: Colors.white,
  fontSize: tm * 2.2,
);

final kTextStyle = TextStyle(
  color: Colors.white,
  fontSize: tm * 2.0,
);

final kTitleTextStyle = TextStyle(
    color: Colors.white, fontSize: tm * 2.5, fontWeight: FontWeight.w700);
final kBodyTextStyle = TextStyle(
  color: Colors.white,
  fontSize: tm * 2.0,
);
final kDrawerTextStyle = TextStyle(
  color: kPrimaryColor,
  fontSize: tm * 2.7,
);

final AlertStyle kAlertStyle = AlertStyle(
  titleStyle: TextStyle(
      fontSize: 2.5 * tm, color: kPrimaryColor, fontWeight: FontWeight.bold),
  descStyle: TextStyle(fontSize: tm * 2),
);

const kTextFieldDecoration2 = InputDecoration(
  hintText: '',
  hasFloatingPlaceholder: false,
  hintStyle: TextStyle(color: Colors.white70),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white30, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white30, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
final kTableHeaderStyle =
    TextStyle(fontWeight: FontWeight.w600, color: kPrimaryColor);
