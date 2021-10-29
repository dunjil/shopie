import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopie/utils/size_config.dart';
import 'apptheme/defaultTheme.dart';
import 'screens/splashscreen.dart';

main() async {
  return runApp(ShopieApp());
}

class ShopieApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          title: 'Shopie',
          theme: defaultTheme,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      });
    });
  }
}
