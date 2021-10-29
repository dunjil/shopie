import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopie/constants/color_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopie/utils/size_config.dart';

class CreateButtonWithIconLg extends StatelessWidget {
  final Function onPressed;
  final String title;
  final String assetLocation;
  CreateButtonWithIconLg({this.title, this.assetLocation, this.onPressed});
  @override
  Widget build(BuildContext context) {
    double tm = SizeConfig.textMultiplier;
    double im = SizeConfig.imageSizeMultiplier;
    double hm = SizeConfig.heightMultiplier;
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        height: hm * 8,
        width: im * 130,
        decoration: BoxDecoration(
          color: kSecondColor,
          borderRadius: BorderRadius.circular(im * 15),
        ),
        child: Center(
          child: Padding(
              padding: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Image(
                        image: AssetImage(assetLocation),
                        height: 8.8 * im,
                        width: 8.8 * im,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "  $title",
                      style: GoogleFonts.roboto(
                          color: kPrimaryColor,
                          fontSize: 2.0 * tm,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
