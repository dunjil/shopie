import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopie/apptheme/defaultTheme.dart';
import 'package:shopie/constants/logo_icon_constants.dart';
import 'package:shopie/constants/style_constants.dart';
import 'package:shopie/screens/home_screen.dart';
import 'package:shopie/utils/size_config.dart';

import 'select_module_screen.dart';
import 'splashscreen.dart';

class AppOnBoardingScreen extends StatefulWidget {
  @override
  _AppOnBoardingScreenState createState() => _AppOnBoardingScreenState();
}

class _AppOnBoardingScreenState extends State<AppOnBoardingScreen> {
  @override
  void initState() {
    if (rememberMe) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    }

    super.initState();
  }

  final int _numberOfPages = 5;
  final _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    double tm = SizeConfig.textMultiplier;
    double im = SizeConfig.imageSizeMultiplier;
    double hm = SizeConfig.heightMultiplier;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                primaryColor,
                primaryColor,
                primaryColor,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: hm * 4.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => SelectModuleScreen()),
                      );
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: tm * 2.5,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: hm * 75,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int value) {
                      setState(() {
                        _currentPage = value;
                      });
                    },
                    children: <Widget>[
                      OnBoardingItem(
                        imageAsset: kShopieLogo2,
                        title: "Dear Business Owner",
                        description: "Your customers at your finger tip",
                      ),
                      OnBoardingItem(
                        imageAsset: kShopieLogo2,
                        title: "Shop at Ease",
                        description:
                            "Shop at your convenience. We save you time and money",
                      ),
                      OnBoardingItem(
                        imageAsset: kShopieLogo2,
                        title: "Shop at Ease",
                        description: "Your customers at your finger tip",
                      ),
                      OnBoardingItem(
                        imageAsset: kShopieLogo2,
                        title: "Your customers",
                        description:
                            "You don't have to go out there looking, we have done that for you",
                      ),
                      OnBoardingItem(
                        imageAsset: kShopieLogo2,
                        title: "Get you most preferred services",
                        description:
                            "You don't have to go out there looking, we have done that for you",
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buildPageIndicator(),
                ),
                SizedBox(
                  height: hm * 4.0,
                ),
                _currentPage != _numberOfPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Next",
                                  style:
                                      kTextStyle.copyWith(fontSize: tm * 2.5),
                                ),
                                SizedBox(
                                  width: im * 4,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: im * 7,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text("")
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numberOfPages - 1
          ? Container(
              decoration: BoxDecoration(color: Colors.white),
              height: hm * 14,
              width: double.infinity,
              child: FlatButton(
                color: Colors.transparent,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(im * 7.0),
                    child: Text(
                      "Get Started >>",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: tm * 3.2,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => SelectModuleScreen()),
                  );
                },
              ),
            )
          : Text(""),
    );
  }

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numberOfPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 150,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      height: hm * 1.4,
      width: isActive ? im * 7 : im * 4,
      decoration: BoxDecoration(
        color: isActive ? secondColor : Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(im * 3.8),
        ),
      ),
    );
  }
}

class OnBoardingItem extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String description;
  OnBoardingItem({this.imageAsset, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(im * 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(kShopieLogo2),
              height: hm * 30,
              width: im * 75,
            ),
          ),
          SizedBox(
            height: hm * 5.0,
          ),
          Text(
            title,
            style: kTextStyle.copyWith(
                fontWeight: FontWeight.w700, fontSize: tm * 2.8),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: hm * 2,
          ),
          Text(
            description,
            style: kBodyTextStyle.copyWith(fontSize: tm * 2.4),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
