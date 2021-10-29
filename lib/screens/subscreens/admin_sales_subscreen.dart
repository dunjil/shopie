import 'package:flutter/material.dart';
import 'package:shopie/screens/admin_opening_balance_screen.dart';
import '../../widgets/admin_item_widget.dart';

class AdminSalesSubScreen extends StatefulWidget {
  final Function startSales;
  final Function endSales;
  AdminSalesSubScreen({this.startSales, this.endSales});
  @override
  _AdminSalesSubScreenState createState() => _AdminSalesSubScreenState();
}

class _AdminSalesSubScreenState extends State<AdminSalesSubScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          children: <Widget>[
            AdminItem(
              title: "Manage Sales",
              assetLoc: 'assets/img/sell_stock_light.png',
              onPress: () {},
            ),
            AdminItem(
              title: "Sales Analyzer",
              assetLoc: 'assets/img/statistics_light.png',
              onPress: () {},
            ),
            AdminItem(
              title: "Opening Balance",
              assetLoc: 'assets/img/money_light.png',
              onPress: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return AdminOpeningBalance();
                  }),
                );
              },
            ),
            AdminItem(
              title: "Start Sales",
              assetLoc: 'assets/img/checkout_light.png',
              onPress: widget.startSales,
            ),
            AdminItem(
              title: "End Sales",
              assetLoc: 'assets/img/manual_light.png',
              onPress: widget.endSales,
            ),
          ],
        ));
  }
}
