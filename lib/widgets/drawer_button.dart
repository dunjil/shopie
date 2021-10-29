import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopie/constants/color_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopie/utils/size_config.dart';

class DrawerButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final String assetLocation;

  DrawerButton({this.title, this.assetLocation, this.onPressed});

  @override
  Widget build(BuildContext context) {
    double tm = SizeConfig.textMultiplier;
    double im = SizeConfig.imageSizeMultiplier;
    double hm = SizeConfig.heightMultiplier;
    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
      ),
      width: MediaQuery.of(context).size.width * 0.80,
      child: FlatButton(
        child: Padding(
            padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image(
                  color: Colors.white,
                  image: AssetImage(assetLocation),
                  height: hm * 4.5,
                  width: hm * 4.5,
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(
                  width: im * 6.5,
                ),
                Text(
                  title,
                  style: GoogleFonts.roboto(
                      color: kHomePanelColor,
                      fontSize: tm * 2.5,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.left,
                ),
              ],
            )),
        onPressed: onPressed,
        color: kDrawerColor,
      ),
    );
  }
}
