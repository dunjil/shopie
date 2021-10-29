import 'package:flutter/material.dart';
import 'package:shopie/screens/admin_get_accounts_screen.dart';
import '../../widgets/admin_item_widget.dart';
import '../admin_create_account_screen.dart';

class AdminAccountsSubScreen extends StatefulWidget {
  @override
  _AdminAccountsSubScreenState createState() => _AdminAccountsSubScreenState();
}

class _AdminAccountsSubScreenState extends State<AdminAccountsSubScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        children: <Widget>[
          AdminItem(
            title: "Create Account",
            assetLoc: 'assets/img/plus_light.png',
            onPress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AdminCreateAccount()));
            },
          ),
          AdminItem(
            title: "Manage Account",
            assetLoc: 'assets/img/editusermale_light.png',
            onPress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => GetAccountsScreen()));
            },
          ),
        ],
      ),
    );
  }
}
