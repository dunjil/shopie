import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shopie/constants/logo_icon_constants.dart';
import 'package:shopie/constants/style_constants.dart';
import '../constants/color_constants.dart';
import '../utils/size_config.dart';
import '../widgets/drawer_button.dart';
import 'splashscreen.dart';
import 'subscreens/admin_accounts_subscreen.dart';
import 'subscreens/admin_finances_subscreen.dart';
import 'subscreens/admin_home_subscreen.dart';
import 'subscreens/admin_sales_subscreen.dart';
import 'subscreens/admin_stock_subscreen.dart';
import 'package:shopie/constants/color_constants.dart';
import 'package:shopie/constants/input_constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as _http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  bool _isLoading = false;
  String selectedWidget = "home";
  @override
  void initState() {
    selectedWidget = "home";
    super.initState();
  }

  _startSales() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _http.Response response = await _http.post(kStartSalesUrl, headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }, body: {
        "business_id": businessId,
        "staff": staff,
      });
      setState(() {
        _isLoading = false;
      });
      String status = response.body;
      // print("Your status is $status");
      if (status == "error") {
        Alert(
          style: kAlertStyle,
          context: context,
          type: AlertType.error,
          imageHeight: hm * 4.5,
          imageWidth: im * 6.5,
          title: "Error",
          desc: "Sales already on",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: tm * 2.6,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.transparent,
            ),
          ],
        ).show();
      } else if (status == "opened") {
        Alert(
          style: kAlertStyle,
          context: context,
          type: AlertType.success,
          imageHeight: hm * 4.5,
          imageWidth: im * 6.5,
          title: "Sales on",
          desc: "Sales Already On",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: tm * 2.6,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.transparent,
            ),
          ],
        ).show();
      } else if (status == "success") {
        Alert(
          style: kAlertStyle,
          context: context,
          type: AlertType.success,
          imageHeight: hm * 4.5,
          imageWidth: im * 6.5,
          title: "Success",
          desc: "Sales started Successfully",
          buttons: [
            DialogButton(
              child: Text(
                "cancel",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: tm * 2.6,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.transparent,
            ),
          ],
        ).show();
      }
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
        desc: "Check your internet connection",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: tm * 2.6,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () => Navigator.pop(context),
            color: Colors.transparent,
          ),
        ],
      ).show();
    }
  }

  _endSales() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _http.Response response = await _http.post(kEndSalesUrl, headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }, body: {
        "business_id": businessId,
        "staff": staff,
      });
      setState(() {
        _isLoading = false;
      });
      // var data = json.decode(response.body);
      String status = response.body;
      if (status == "sales already closed") {
        Alert(
          style: kAlertStyle,
          context: context,
          type: AlertType.warning,
          imageHeight: hm * 4.5,
          imageWidth: im * 6.5,
          title: "Error",
          desc: "Sales are not on. You can only end sales when sales are on.",
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: tm * 2.6,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pop(context),
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
          desc: "Check your internet connection",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: tm * 2.6,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.transparent,
            ),
          ],
        ).show();
      } else if (status == "success") {
        Alert(
          style: kAlertStyle,
          context: context,
          type: AlertType.success,
          imageHeight: hm * 4.5,
          imageWidth: im * 6.5,
          title: "Success!",
          desc: "Sales successfully closed",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: tm * 2.6,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.transparent,
            ),
          ],
        ).show();
      }
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
        desc: "Check your internet connection\n ${e.toString()}",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: tm * 2.6,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () => Navigator.pop(context),
            color: Colors.transparent,
          ),
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    double tm = SizeConfig.textMultiplier;
    double im = SizeConfig.imageSizeMultiplier;
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopie"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            image: DecorationImage(
              image: AssetImage(
                "assets/img/splashscreen.png",
              ),
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.065), BlendMode.dstATop),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: kPrimaryColor),
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
                          style: kTextStyle,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: kSecondColor,
                child: SingleChildScrollView(
                  child: selectedSubScreen(subWidget: selectedWidget),
                ),
              ),
            ],
          ),
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
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  selectedWidget = "stock";
                  selectedSubScreen(subWidget: selectedWidget);
                });
              },
              assetLocation: "assets/img/gold_bars.png",
            ),
            DrawerButton(
              title: "Sales",
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  selectedWidget = "sales";
                  selectedSubScreen(subWidget: selectedWidget);
                });
              },
              assetLocation: "assets/img/checkout.png",
            ),
            DrawerButton(
              title: "Accounts",
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  selectedWidget = "accounts";
                  selectedSubScreen(subWidget: selectedWidget);
                });
              },
              assetLocation: "assets/img/conference.png",
            ),
            DrawerButton(
              title: "Finances",
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  selectedWidget = "finances";
                  selectedSubScreen(subWidget: selectedWidget);
                });
              },
              assetLocation: "assets/img/bank_note.png",
            ),
            DrawerButton(
              title: "My Shops",
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  selectedWidget = "home";
                  selectedSubScreen(subWidget: selectedWidget);
                });
              },
              assetLocation: "assets/img/new_product.png",
            ),
            DrawerButton(
              title: "Location",
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  selectedWidget = "home";
                  selectedSubScreen(subWidget: selectedWidget);
                });
              },
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          "assets/img/chat.png",
          height: hm * 5,
          width: im * 9.5,
          fit: BoxFit.fitHeight,
        ),
        backgroundColor: kSecondColor,
        onPressed: () {},
      ),
    );
  }

  _confirmStartSales() {
    Alert(
      style: kAlertStyle,
      context: context,
      type: AlertType.warning,
      title: "Warning",
      imageHeight: hm * 4.5,
      imageWidth: im * 6.5,
      desc:
          "You're about to start sales. This will enable cashiers to make sales as long as you don't end sales.\n\nDo You wish to continue? ",
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: tm * 2.6,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
            _startSales();
          },
          color: Colors.transparent,
          width: im * 4.0,
        ),
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: tm * 2.6,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.transparent,
          width: im * 4.0,
        ),
      ],
    ).show();
  }

  _confirmEndSales() {
    Alert(
      style: kAlertStyle,
      context: context,
      type: AlertType.warning,
      imageHeight: hm * 4.5,
      imageWidth: im * 6.5,
      title: "Warning",
      desc:
          "You're about to end ongoing sales. This will stop cashiers from making sales.\n\nDo You wish to continue? ",
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: tm * 2.6,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
            _endSales();
          },
          color: Colors.transparent,
        ),
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: tm * 2.6,
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

  Widget selectedSubScreen({String subWidget}) {
    switch (subWidget) {
      case ("accounts"):
        return AdminAccountsSubScreen();
        break;
      case ("finances"):
        return AdminFinancesSubScreen();
        break;
      case ("home"):
        return AdminHomeSubScreen();
        break;
      case ("sales"):
        return AdminSalesSubScreen(
          startSales: _confirmStartSales,
          endSales: _confirmEndSales,
        );
        break;
      case ("stock"):
        return AdminStockSubScreen();
        break;
      default:
        return AdminAccountsSubScreen();
    }
  }
}
