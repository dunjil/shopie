import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopie/constants/input_constants.dart';
import '../constants/color_constants.dart';
import '../constants/style_constants.dart';
import 'package:http/http.dart' as _http;
import 'dart:convert';
import 'splashscreen.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _categoryController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  List _categories = [];

  @override
  void initState() {
    _getCategoriesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Add Category",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(im * 3),
                width: containerWidth,
                decoration: BoxDecoration(
                  color: kHomePanelColor,
                  borderRadius: BorderRadius.circular(im * 2),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _categoryController,
                        style: kTextFieldStyle.copyWith(
                            color: kPrimaryColor, fontSize: tm * 2.1),
                        cursorColor: kPrimaryColor,
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: "Category",
                          labelStyle: GoogleFonts.roboto(color: kPrimaryColor),
                        ),
                        validator: (String text) {
                          if (text.trim().isEmpty) {
                            return "Text can't be null";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: FlatButton(
                        child: _isLoading
                            ? Text(
                                "Loading",
                                style: TextStyle(
                                    color: kSecondColor, fontSize: tm * 1.7),
                              )
                            : Text(
                                "Add Category",
                                style: TextStyle(
                                    color: kSecondColor, fontSize: tm * 1.7),
                              ),
                        color: kPrimaryColor,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            !_isLoading ? _addCategory() : print("kindly wait");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                  width: containerWidth,
                  height: MediaQuery.of(context).size.height * 0.6,
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(im * 3),
                  decoration: BoxDecoration(
                    color: kHomePanelColor,
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  child: ListView(
                    children: <Widget>[
                      DataTable(
                        columns: [
                          DataColumn(
                              label: Text("SN", style: kTableHeaderStyle)),
                          DataColumn(
                              label: Text("Category", style: kTableHeaderStyle))
                        ],
                        rows: _categories == null
                            ? [
                                DataRow(cells: <DataCell>[
                                  DataCell(Text("")),
                                  DataCell(Text("")),
                                ])
                              ]
                            : _categories
                                .map(
                                  (category) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(
                                          "${_categories.indexOf(category) + 1}")),
                                      DataCell(
                                        Text(category["category"]),
                                      ), //Extracting from Map element the value
                                    ],
                                  ),
                                )
                                .toList(),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  _addCategory() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _http.Response response =
          await _http.post(kAddProductCategoryUrl, headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }, body: {
        "business_id": businessId,
        "category": _categoryController.text,
      });
      setState(() {
        _isLoading = false;
        _categoryController.clear();
      });

      var data = json.decode(response.body);
      String status = data["status"];
      if (status == "exists") {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Product Category Exists'),
          duration: Duration(seconds: 3),
        ));
      } else if (status == "error") {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Error in Adding category'),
          duration: Duration(seconds: 3),
        ));
      } else if (status == "success") {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Product Category Added'),
          duration: Duration(seconds: 3),
        ));
        setState(() {
          _isLoading = false;
        });
        _getCategoriesList();
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Category Add Successfully'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future _getCategoriesList() async {
    await _http.post(kGetProductCategoriesUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "business_id": businessId,
    }).then((response) {
      var data = json.decode(response.body);
      setState(() {
        _categories = data["data"];
      });
    });
  }
}
