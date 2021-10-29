import 'package:flutter/material.dart';
import '../../widgets/admin_item_widget.dart';

class AdminFinancesSubScreen extends StatefulWidget {
  @override
  _AdminFinancesSubScreenState createState() => _AdminFinancesSubScreenState();
}

class _AdminFinancesSubScreenState extends State<AdminFinancesSubScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: GridView.count(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          crossAxisCount: 3,
          children: <Widget>[
            AdminItem(
              title: "Expenditure",
              assetLoc: 'assets/img/paycheck_light.png',
              onPress: () {},
            ),
            AdminItem(
              title: "Financial Report",
              assetLoc: 'assets/img/plus_light.png',
              onPress: () {},
            ),
          ],
        ));
  }
}
