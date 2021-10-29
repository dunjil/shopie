import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants/color_constants.dart';
import '../constants/logo_icon_constants.dart';
import '../constants/style_constants.dart';
import '../utils/size_config.dart';
import '../widgets/dashboard_item.dart';
import '../widgets/drawer_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_home_screen.dart';
import 'splashscreen.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String bizId = prefs.getString("business_id");
    String staffEmail = prefs.getString("staff");
    businessId = bizId;
    staff = staffEmail;
  }

  @override
  void initState() {
    _loadPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double tm = SizeConfig.textMultiplier;
    double im = SizeConfig.imageSizeMultiplier;
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopie"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.065), BlendMode.dstATop),
            fit: BoxFit.fitHeight,
            image: AssetImage(
              "assets/img/splashscreen.png",
            ),
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    radius: 10 * im,
                    child: Image.asset(
                      kShopieLogo2,
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ),
                  SizedBox(
                    width: im * 6.5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "DiLaw's Boutique",
                        style: kTextStyle.copyWith(
                            fontSize: tm * 2.5, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "KM 21, Aliade road, Gboko",
                        style: kTextStyle.copyWith(fontSize: tm * 2.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: DashboardItem(
                    title: "Items Sold",
                    assetLoc: "assets/img/new_product.png",
                    value: 0,
                  ),
                ),
                Expanded(
                  child: DashboardItem(
                    title: "Amount Sold",
                    assetLoc: "assets/img/stack_of_money.png",
                    value: 0,
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: DashboardItem(
                    title: "Opening Balance",
                    assetLoc: "assets/img/open_in_popup.png",
                    value: 0,
                  ),
                ),
                Expanded(
                  child: DashboardItem(
                    title: "Cash at Hand",
                    assetLoc: "assets/img/cash_in_hand.png",
                    value: 0,
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: DashboardItem(
                    title: "Pending Orders",
                    assetLoc: "assets/img/order_history.png",
                    value: 0,
                  ),
                ),
                Expanded(
                  child: DashboardItem(
                    title: "Processed Orders",
                    assetLoc: "assets/img/purchase_order.png",
                    value: 0.0,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      drawer: Container(
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
                              Navigator.pop(context);
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
              onPressed: () {
                Navigator.pop(context);
              },
              assetLocation: "assets/img/market_square.png",
            ),
            DrawerButton(
              title: "Online Orders",
              onPressed: () {},
              assetLocation: "assets/img/online_payment.png",
            ),
            DrawerButton(
              title: "Sales History",
              onPressed: () {
                Navigator.pop(context);
              },
              assetLocation: "assets/img/filing_cabinet.png",
            ),
            DrawerButton(
              title: "Administrator",
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
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
              onPressed: () {
                Navigator.pop(context);
              },
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          "assets/img/chat.png",
          height: 30,
          width: 30,
          fit: BoxFit.fitHeight,
        ),
        backgroundColor: kSecondColor,
        onPressed: () {},
      ),
    );
  }
}
