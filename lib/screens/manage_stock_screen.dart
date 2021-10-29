import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopie/constants/input_constants.dart';
import 'package:shopie/models/products_model.dart';
import 'package:shopie/screens/view_stock_screen.dart';
import '../constants/color_constants.dart';
import '../constants/style_constants.dart';
import 'package:http/http.dart' as _http;
import 'dart:convert';
import 'splashscreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ManageStockScreen extends StatefulWidget {
  @override
  _ManageStockScreenState createState() => _ManageStockScreenState();
}

class _ManageStockScreenState extends State<ManageStockScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool hideProduct = false;
  bool _isLoading = false;
  List _categories = [];
  List<Product> _products = [];
  String _category;
  @override
  void initState() {
    _getCategoriesList();
    _getProductsList();
    super.initState();
  }

  Future _getCategoriesList() async {
    await _http.post(kGetProductCategoriesUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "business_id": businessId,
    }).then((response) {
      var data = json.decode(response.body);
      List listData = data["data"];
      List catList = [];
      listData.forEach((data) {
        catList.add(data["category"]);
      });
      setState(() {
        _categories = catList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Manage Stock",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(im * 3),
              width: containerWidth,
              decoration: BoxDecoration(
                color: kHomePanelColor,
                borderRadius: BorderRadius.circular(im * 2),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            focusColor: Colors.white,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: kHomePanelColor,
                              ),
                              child: DropdownButton(
                                value: _category,
                                hint: Text(
                                  "Category",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: tm * 2.0),
                                ),
                                iconEnabledColor: kPrimaryColor,
                                iconDisabledColor: kPrimaryColor,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 2.0 * tm,
                                ),
                                items: _categories.map((cat) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          cat,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: tm * 2.0),
                                        ),
                                        value: cat,
                                      );
                                    })?.toList() ??
                                    [],
                                onChanged: (item) {
                                  setState(() {
                                    _category = item;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: im * 2,
                      ),
                      Expanded(
                        child: FlatButton(
                          child: Text(
                            "Load Category",
                            style: TextStyle(
                                color: kSecondColor, fontSize: tm * 1.7),
                          ),
                          color: kPrimaryColor,
                          onPressed: () {
                            _getProductsByCategory(category: _category);
                          },
                        ),
                      ),
                      SizedBox(
                        width: im * 2,
                      ),
                      Expanded(
                        child: FlatButton(
                          child: Text(
                            "Items at QTY Limit",
                            style: TextStyle(
                                color: kSecondColor, fontSize: tm * 1.7),
                          ),
                          color: kPrimaryColor,
                          onPressed: () {
                            _getProductsList();
                          },
                        ),
                      ),
                      SizedBox(
                        width: im * 2,
                      ),
                      Expanded(
                        child: FlatButton(
                          child: Text(
                            "Sort By Category",
                            style: TextStyle(
                                color: kSecondColor, fontSize: tm * 1.7),
                          ),
                          color: kPrimaryColor,
                          onPressed: () {
                            _getSortedProductsList();
                          },
                        ),
                      ),
                    ],
                  )
                ],
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
                                label: Text("ITEM", style: kTableHeaderStyle)),
                            DataColumn(
                                label:
                                    Text("CATEGORY", style: kTableHeaderStyle)),
                            DataColumn(
                                label: Text("UNIT PRICE",
                                    style: kTableHeaderStyle)),
                            DataColumn(
                                label: Text("SELLING PRICE",
                                    style: kTableHeaderStyle)),
                            DataColumn(
                                label: Text("QTY", style: kTableHeaderStyle)),
                            DataColumn(
                                label: Text("QTY LIMIT",
                                    style: kTableHeaderStyle)),
                            DataColumn(
                                label: Text("BRAND", style: kTableHeaderStyle)),
                            DataColumn(
                              label: Text(""),
                            )
                          ],
                          rows: _products == null
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
                              : _products
                                  .map(
                                    (product) => DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(
                                            "${_products.indexOf(product) + 1}")),
                                        DataCell(
                                          Text(product.item),
                                        ),
                                        DataCell(
                                          Text(product.category),
                                        ),
                                        DataCell(
                                          Text("${product.unitPrice}"),
                                        ),
                                        DataCell(
                                          Text("${product.sellingPrice}"),
                                        ),
                                        DataCell(
                                          Text("${product.quantity}"),
                                        ),
                                        DataCell(
                                          Text("${product.quantityLimit}"),
                                        ),
                                        DataCell(
                                          Text(product.brand),
                                        ),
                                        DataCell(
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(
                                                  Icons.visibility,
                                                  color: kPrimaryColor,
                                                  size: im * 7,
                                                ),
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) {
                                                    return ViewStockScreen(
                                                      productId:
                                                          product.id.toString(),
                                                    );
                                                  }));
                                                },
                                              ),
                                              Switch(
                                                value: !hideProduct,
                                                onChanged: (val) {
                                                  print(
                                                      "Item with Id: ${product.id} Toggled");
                                                },
                                                activeColor: Colors.green,
                                                inactiveThumbColor: Colors.grey,
                                                inactiveTrackColor:
                                                    Colors.grey.shade700,
                                                activeTrackColor:
                                                    Colors.green.shade200,
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

  Future _getProductsList() async {
    setState(() {
      _isLoading = true;
    });
    await _http.post(kGetProductsUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "business_id": businessId,
    }).then((response) {
      var data = json.decode(response.body);
      if (data["status"] == "found") {
        List productsMap = data["data"];
        List<Product> prods =
            productsMap.map((prod) => Product.fromJson(prod)).toList();
        setState(() {
          _products = prods;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        _errorSnackBar(message: "No Product Found For this Business");
      }
    });
  }

  Future _getSortedProductsList() async {
    setState(() {
      _isLoading = true;
    });
    await _http.post(kGetProductSortedUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "business_id": businessId,
    }).then((response) {
      var data = json.decode(response.body);
      if (data["status"] == "found") {
        List productsMap = data["data"];
        List<Product> prods =
            productsMap.map((prod) => Product.fromJson(prod)).toList();

        setState(() {
          _products = prods;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        _errorSnackBar(message: "No product found for this Business");
      }
    });
  }

  Future _getProductsByCategory({String category}) async {
    if (category != null) {
      setState(() {
        _isLoading = true;
      });
      await _http.post(kGetProductByCategoryUrl, headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }, body: {
        "business_id": businessId,
        "category": category,
      }).then((response) {
        var data = json.decode(response.body);
        if (data["status"] == "found") {
          List productsMap = data["data"];
          List<Product> prods =
              productsMap.map((prod) => Product.fromJson(prod)).toList();
          setState(() {
            _products = prods;
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          _errorSnackBar(message: "No product of the category: $category");
        }
      });
    } else {
      _errorSnackBar(message: "Please Select A Category");
    }
  }

  _errorSnackBar({String message}) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 3),
    ));
  }
}
