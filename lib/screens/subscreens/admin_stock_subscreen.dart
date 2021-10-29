import 'package:flutter/material.dart';
import 'package:shopie/screens/add_stock_screen.dart';
import 'package:shopie/screens/manage_stock_screen.dart';
import '../../widgets/admin_item_widget.dart';
import '../add_category_screen.dart';

class AdminStockSubScreen extends StatefulWidget {
  @override
  _AdminStockSubScreenState createState() => _AdminStockSubScreenState();
}

class _AdminStockSubScreenState extends State<AdminStockSubScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          children: <Widget>[
            AdminItem(
              title: "Categories",
              assetLoc: 'assets/img/categories_light.png',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return AddCategoryScreen();
                  }),
                );
              },
            ),
            AdminItem(
              title: "Add Stock",
              assetLoc: 'assets/img/plus_light.png',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return AddStockScreen();
                  }),
                );
              },
            ),
            AdminItem(
              title: "Manage Stock",
              assetLoc: 'assets/img/box_light.png',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return ManageStockScreen();
                  }),
                );
              },
            ),
          ],
        ));
  }
}
