import 'package:flutter/material.dart';
import '../apptheme/defaultTheme.dart';
import '../utils/size_config.dart';

class AdminItem extends StatelessWidget {
  final String title;
  final Function onPress;
  final String assetLoc;
  AdminItem({this.title, this.onPress, this.assetLoc});
  @override
  Widget build(BuildContext context) {
    double tm = SizeConfig.textMultiplier;
    double im = SizeConfig.imageSizeMultiplier;
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.only(
            top: im * 1, bottom: im * 1, left: 1.2, right: im * 1.2),
        margin: EdgeInsets.all(im * 1.3),
        height: MediaQuery.of(context).size.height * 0.06,
        width: im * 30,
        decoration: BoxDecoration(
            color: Color(0XFF380059),
            borderRadius: BorderRadius.circular(im * 2.5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              assetLoc,
              height: im * 13.5,
              width: im * 13.5,
              fit: BoxFit.fitHeight,
            ),
            Text(
              title,
              style: TextStyle(
                  color: secondColor,
                  fontSize: tm * 2.0,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
