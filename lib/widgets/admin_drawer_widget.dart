import 'package:flutter/material.dart';
import 'package:shopie/constants/color_constants.dart';
import 'package:shopie/utils/size_config.dart';

import 'drawer_button.dart';

class AdminDrawerWidget extends StatefulWidget {
  @override
  _AdminDrawerWidgetState createState() => _AdminDrawerWidgetState();
}

class _AdminDrawerWidgetState extends State<AdminDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    double tm = SizeConfig.textMultiplier;
    double im = SizeConfig.imageSizeMultiplier;
    double hm = SizeConfig.heightMultiplier;
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
                          onPressed: () {},
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
            title: "Stock",
            onPressed: () {},
            assetLocation: "assets/img/gold_bars.png",
          ),
          DrawerButton(
            title: "Sales",
            onPressed: () {},
            assetLocation: "assets/img/checkout.png",
          ),
          DrawerButton(
            title: "Accounts",
            onPressed: () {},
            assetLocation: "assets/img/conference.png",
          ),
          DrawerButton(
            title: "Finances",
            onPressed: () {},
            assetLocation: "assets/img/bank_note.png",
          ),
          DrawerButton(
            title: "My Shops",
            onPressed: () {},
            assetLocation: "assets/img/new_product.png",
          ),
          DrawerButton(
            title: "Location",
            onPressed: () {},
            assetLocation: "assets/img/geo_fence.png",
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
