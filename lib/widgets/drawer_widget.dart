import 'package:flutter/material.dart';
import 'package:shopie/constants/color_constants.dart';
import 'package:shopie/screens/admin_home_screen.dart';
import 'package:shopie/utils/size_config.dart';
import 'drawer_button.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    double im = SizeConfig.imageSizeMultiplier;
    return Container(
      height: MediaQuery.of(context).size.height * 0.99,
      width: MediaQuery.of(context).size.width * 0.70,
      decoration: BoxDecoration(
        color: kDrawerColor,
      ),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: im * 10,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 0.0,
                        right: 10.0,
                        child: IconButton(
                          color: kPrimaryColor,
                          onPressed: () {
                            return Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AdminHomeScreen(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.photo_camera,
                            size: im * 9,
                            color: kSecondColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  backgroundImage: AssetImage(
                    "assets/img/administrator.png",
                  ),
                  backgroundColor: Colors.grey,
                ),
                SizedBox(height: 10.0),
                Text(
                  "Adu Lawrence",
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 10.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          DrawerButton(
            title: "Make Sales",
            onPressed: () {},
            assetLocation: "assets/img/market_square.png",
          ),
          DrawerButton(
            title: "Online Orders",
            onPressed: () {},
            assetLocation: "assets/img/online_payment.png",
          ),
          DrawerButton(
            title: "Sales History",
            onPressed: () {},
            assetLocation: "assets/img/filing_cabinet.png",
          ),
          DrawerButton(
            title: "Administrator",
            onPressed: () {
              return Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => AdminHomeScreen(),
                ),
              );
            },
            assetLocation: "assets/img/administrator.png",
          ),
          DrawerButton(
            title: "QR Connect",
            onPressed: () {},
            assetLocation: "assets/img/qr_code.png",
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 10.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.0, left: 8.0, right: 10.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 10.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Change Password",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 10.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
