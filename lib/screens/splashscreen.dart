import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopie/screens/apponboarding_screen.dart';
import 'dart:async';
import 'package:shopie/screens/home_screen.dart';
import 'package:notification_permissions/notification_permissions.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

String businessId;
String staff;
bool rememberMe = false;

class _SplashScreenState extends State<SplashScreen> {
  loadBusinessIdPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String bizId = prefs.getString("business_id");
    String staffEmail = prefs.getString("staff");
    bool rememberMePref = prefs.getBool("remember_me");
    businessId = bizId;
    staff = staffEmail;
    if (rememberMePref != null) {
      rememberMe = rememberMePref;
    }
  }

  @override
  void initState() {
    super.initState();
    loadBusinessIdPreferences();
    Timer(
      Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => rememberMe
                ? HomeScreen()
                : businessId != null ? LoginScreen() : AppOnBoardingScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        //color: Theme.of(context).primaryColor,
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage(
            "assets/img/splashscreen.png",
          ),
        ),
      ),
    );
  }
}
