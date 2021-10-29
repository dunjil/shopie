import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopie/constants/color_constants.dart';
import 'package:shopie/constants/style_constants.dart';
import 'package:shopie/utils/size_config.dart';

class DashboardItem extends StatelessWidget {
  final double value;
  final String title;
  final String assetLoc;

  DashboardItem({this.title, this.value, this.assetLoc});
  @override
  Widget build(BuildContext context) {
    double tm = SizeConfig.textMultiplier;
    double im = SizeConfig.imageSizeMultiplier;
    double hm = SizeConfig.heightMultiplier;
    return Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: kHomePanelColor,
        borderRadius: BorderRadius.circular(hm * 1.5),
      ),
      height: MediaQuery.of(context).size.height * 0.15,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Image.asset(
              assetLoc,
              height: im * 13.5,
              width: im * 13.5,
              fit: BoxFit.fitHeight,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "$value",
                    style: kDrawerTextStyle.copyWith(
                      fontSize: 3.0 * tm,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    title,
                    style: kDrawerTextStyle.copyWith(
                      fontSize: 2.1 * tm,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
