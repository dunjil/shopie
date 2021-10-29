import 'package:flutter/material.dart';
import '../../widgets/dashboard_item.dart';

class AdminHomeSubScreen extends StatefulWidget {
  @override
  _AdminHomeSubScreenState createState() => _AdminHomeSubScreenState();
}

class _AdminHomeSubScreenState extends State<AdminHomeSubScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
    );
  }
}
