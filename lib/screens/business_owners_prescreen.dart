import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopie/constants/style_constants.dart';
import 'package:shopie/widgets/button_with_icon_lg.dart';
import '../constants/color_constants.dart';
import '../constants/logo_icon_constants.dart';
import 'create_business_account_screen.dart';
import '../utils/size_config.dart';
import '../widgets/button_with_icon_sm.dart';
import 'connect_business_screen.dart';

class BusinessOwnersPrePage extends StatefulWidget {
  @override
  _BusinessOwnersPrePageState createState() => _BusinessOwnersPrePageState();
}

class _BusinessOwnersPrePageState extends State<BusinessOwnersPrePage> {
  @override
  Widget build(BuildContext context) {
    double tm = SizeConfig.textMultiplier;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(12.0),
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
                Text(
                  "CONNECTING BUSINESSES AND CUSTOMERS",
                  style: kTitleTextStyle.copyWith(color: kSecondColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  "Its every business owner's desire to connect with his/her customers. We just made the process easier",
                  style:
                      kBodyTextStyle.copyWith(decoration: TextDecoration.none),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                CreateButtonWithIconLg(
                    title: "Create Business Account",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BusinessAccountSignUpScreen()));
                    },
                    assetLocation: "assets/img/shoppingbag.png"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                CreateButtonWithIconLg(
                  title: "Connect My Business",
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ConnectBusinessScreen();
                    }));
                  },
                  assetLocation: "assets/img/qrcode.png",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
