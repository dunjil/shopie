import 'package:flutter/material.dart';
import 'package:shopie/constants/input_constants.dart';
import 'package:shopie/models/staff_model.dart';
import '../constants/color_constants.dart';
import '../constants/style_constants.dart';
import 'package:http/http.dart' as _http;
import 'dart:convert';
import 'splashscreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class GetAccountsScreen extends StatefulWidget {
  @override
  _GetAccountsScreenState createState() => _GetAccountsScreenState();
}

class _GetAccountsScreenState extends State<GetAccountsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  List<Staff> _staffList = [];

  @override
  void initState() {
    _getAccountsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kHomePanelColor,
      appBar: AppBar(
        title: Text(
          "All Accounts",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SingleChildScrollView(
              child: Container(
                  width: containerWidth,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(im * 1.5),
                  margin: EdgeInsets.only(bottom: im * 3),
                  decoration: BoxDecoration(
                    color: kHomePanelColor,
                    // borderRadius: BorderRadius.circular(13.0),
                  ),
                  child: ModalProgressHUD(
                    inAsyncCall: _isLoading,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(
                                label: Text("SN", style: kTableHeaderStyle)),
                            DataColumn(
                                label: Text("NAME", style: kTableHeaderStyle)),
                            DataColumn(
                                label:
                                    Text("ACC TYPE", style: kTableHeaderStyle)),
                            DataColumn(
                                label: Text("EMAIL", style: kTableHeaderStyle)),
                            DataColumn(
                                label: Text("PHONE", style: kTableHeaderStyle)),
                            DataColumn(
                                label:
                                    Text("ADDRESS", style: kTableHeaderStyle)),
                            DataColumn(
                                label: Text("CREATED BY",
                                    style: kTableHeaderStyle)),
                            DataColumn(
                                label: Text("DATE", style: kTableHeaderStyle)),
                            DataColumn(
                              label: Text(""),
                            )
                          ],
                          rows: _staffList == null
                              ? [
                                  DataRow(cells: <DataCell>[
                                    DataCell(Text("")),
                                    DataCell(Text("")),
                                    DataCell(Text("")),
                                    DataCell(Text("")),
                                    DataCell(Text("")),
                                    DataCell(Text("")),
                                    DataCell(Text("")),
                                    DataCell(Text("")),
                                    DataCell(Text("")),
                                  ])
                                ]
                              : _staffList
                                  .map(
                                    (staff) => DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(
                                            "${_staffList.indexOf(staff) + 1}")),
                                        DataCell(
                                          Text(staff.name),
                                        ),
                                        DataCell(
                                          Text(staff.accountType),
                                        ),
                                        DataCell(
                                          Text("${staff.email}"),
                                        ),
                                        DataCell(
                                          Text("${staff.phone}"),
                                        ),
                                        DataCell(
                                          Text("${staff.address}"),
                                        ),
                                        DataCell(
                                          Text("${staff.createdBy}"),
                                        ),
                                        DataCell(
                                          Text(staff.date),
                                        ),
                                        DataCell(
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.red,
                                                  size: im * 7,
                                                ),
                                                onPressed: () {
                                                  _deleteAccount(staff.id);
                                                },
                                              ),
                                            ],
                                          ),
                                        ), //Extracting from Map element the value
                                      ],
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future _getAccountsList() async {
    setState(() {
      _isLoading = true;
    });
    await _http.post(kGetAccountsUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "business_id": businessId,
    }).then((response) {
      var data = json.decode(response.body);
      print("This is the body " + response.body);
      if (data["status"] == "found") {
        List staffMap = data["data"];
        List<Staff> staff =
            staffMap.map((staf) => Staff.fromJson(staf)).toList();
        setState(() {
          _staffList = staff;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        _errorSnackBar(message: "No Staff Found For this Business");
      }
    });
  }

  _deleteAccount(int userId) async {
    setState(() {
      _isLoading = true;
    });
    await _http.post(kDeleteAccountUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "business_id": businessId,
      "user_id": userId,
    }).then((response) {
      print("The response is: "+response.body);
      var status = response.body;
      if (status == "success") {
        setState(() {
          _isLoading = false;
        });
        _errorSnackBar(
            message: "Staff account successfully removed",
            icon: Icons.check_circle,
            color: Colors.green);
      } else {
        setState(() {
          _isLoading = false;
        });
        _errorSnackBar(
            message: "Error, Could not remove selected account",
            icon: Icons.error,
            color: Colors.red);
      }
    });
  }

  _errorSnackBar(
      {@required String message,
      @required IconData icon,
      @required Color color}) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Text(
              "Message",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(icon, color: color),
          )
        ],
      ),
      duration: Duration(seconds: 3),
    ));
  }
}
