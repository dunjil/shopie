import 'package:flutter/material.dart';
import 'package:shopie/screens/business_owners_prescreen.dart';
import 'package:shopie/screens/login_screen.dart';
import '../constants/logo_icon_constants.dart';
import '../widgets/button_with_icon_sm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectModuleScreen extends StatefulWidget {
  @override
  _SelectModuleScreenState createState() => _SelectModuleScreenState();
}

Future loadRegisteredPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool registeredState = prefs.getBool("registered") ?? false;
  return registeredState;
}

Future loadBusinessIdPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String businessId = prefs.getString("business_id");
  return businessId;
}

class _SelectModuleScreenState extends State<SelectModuleScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            kShopieLogo2,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          CreateButtonWithIconSm(
            title: "For Businesses",
            onPressed: () async {
              loadRegisteredPreferences().then((value) {
                if (value) {
                  loadBusinessIdPreferences().then((value) {
                    if (value != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginScreen()));
                    }
                  });
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BusinessOwnersPrePage()));
                }
              });
            },
            assetLocation: "assets/img/sales.png",
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          CreateButtonWithIconSm(
              title: "For Buyers",
              onPressed: () {},
              assetLocation: "assets/img/buyers.png"),
        ],
      ),
    );
  }
}
