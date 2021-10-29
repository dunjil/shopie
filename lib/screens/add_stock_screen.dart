import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants/input_constants.dart';
import '../constants/color_constants.dart';
import '../constants/style_constants.dart';
import '../widgets/button_with_icon_sm.dart';
import 'package:http/http.dart' as _http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:shopie/notification.dart' as noti;
import 'splashscreen.dart';

const upLoadFiles = "uploadTask";
const check = "check";

class AddStockScreen extends StatefulWidget {
  @override
  _AddStockScreenState createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  noti.Notification notification = new noti.Notification();
  File image1;
  File image2;
  File image3;
  File image4;
  File image5;
  bool im1 = false;
  bool im2 = false;
  bool im3 = false;
  bool im4 = false;
  bool im5 = false;
  final picker = ImagePicker();
  PickedFile picko;
  File _video;
  bool _vid = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isUploadingFiles = false;
  TextEditingController _stockName = TextEditingController();
  TextEditingController _code = TextEditingController();
  TextEditingController _unitPrice = TextEditingController();
  TextEditingController _oldPrice = TextEditingController();
  TextEditingController _sellingPrice = TextEditingController();
  TextEditingController _weight = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  TextEditingController _quantityLimit = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _brand = TextEditingController();
  String productId;
  String _category;
  List _categories = [];

  @override
  initState() {
    super.initState();
    _getCategoriesList();
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

  clearInputFields() {
    setState(() {
      _stockName.clear();
      _code.clear();
      _unitPrice.clear();
      _oldPrice.clear();
      _sellingPrice.clear();
      _weight.clear();
      _quantity.clear();
      _quantityLimit.clear();
      _description.clear();
      _brand.clear();
    });
  }

  clearFileFields() {
    setState(() {
      image1 = null;
      image2 = null;
      image3 = null;
      image4 = null;
      image5 = null;
      im1 = false;
      im2 = false;
      im3 = false;
      im4 = false;
      im5 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add Stock"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: im * 0.5, horizontal: im * 5.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
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
                  Divider(
                    color: kPrimaryColor,
                    thickness: 1,
                  ),
                  TextFormField(
                    controller: _stockName,
                    style: kTextFieldStyle.copyWith(color: Colors.black),
                    cursorColor: kPrimaryColor,
                    decoration: k2TextFieldDecoration.copyWith(
                      labelText: "Name",
                      labelStyle: GoogleFonts.roboto(
                          color: kPrimaryColor, fontSize: tm * 2.0),
                    ),
                    validator: (String text) {
                      if (text.length < 3) {
                        return "Please provide a valid stock name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _code,
                    style: kTextFieldStyle.copyWith(color: Colors.black),
                    cursorColor: kPrimaryColor,
                    decoration: k2TextFieldDecoration.copyWith(
                      labelText: "Code",
                      labelStyle: GoogleFonts.roboto(
                          color: kPrimaryColor, fontSize: tm * 2.0),
                    ),
                    validator: (String text) {
                      if (text.length < 3) {
                        return "Please provide a valid stock code";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _unitPrice,
                    keyboardType: TextInputType.number,
                    style: kTextFieldStyle.copyWith(color: Colors.black),
                    cursorColor: kPrimaryColor,
                    decoration: k2TextFieldDecoration.copyWith(
                      labelText: "Unit Price",
                      labelStyle: GoogleFonts.roboto(
                          color: kPrimaryColor, fontSize: tm * 2.0),
                    ),
                    validator: (String text) {
                      if (text.isEmpty) {
                        return "Please provide a unit price";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _sellingPrice,
                    keyboardType: TextInputType.number,
                    style: kTextFieldStyle.copyWith(color: Colors.black),
                    cursorColor: kPrimaryColor,
                    decoration: k2TextFieldDecoration.copyWith(
                      labelText: "Selling Price",
                      labelStyle: GoogleFonts.roboto(
                          color: kPrimaryColor, fontSize: tm * 2.0),
                    ),
                    validator: (String text) {
                      if (text.length < 3) {
                        return "Please provide a valid stock name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _oldPrice,
                    keyboardType: TextInputType.number,
                    style: kTextFieldStyle.copyWith(color: Colors.black),
                    cursorColor: kPrimaryColor,
                    decoration: k2TextFieldDecoration.copyWith(
                      labelText: "Old Price (Optional)",
                      labelStyle: GoogleFonts.roboto(
                          color: kPrimaryColor, fontSize: tm * 2.0),
                    ),
                    validator: (String text) {
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _weight,
                    keyboardType: TextInputType.number,
                    style: kTextFieldStyle.copyWith(color: Colors.black),
                    cursorColor: kPrimaryColor,
                    decoration: k2TextFieldDecoration.copyWith(
                      labelText: "Weight (kg)",
                      labelStyle: GoogleFonts.roboto(
                          color: kPrimaryColor, fontSize: tm * 2.0),
                    ),
                    validator: (String text) {
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _quantity,
                    keyboardType: TextInputType.number,
                    style: kTextFieldStyle.copyWith(color: Colors.black),
                    cursorColor: kPrimaryColor,
                    decoration: k2TextFieldDecoration.copyWith(
                      labelText: "Quantity",
                      labelStyle: GoogleFonts.roboto(
                          color: kPrimaryColor, fontSize: tm * 2.0),
                    ),
                    validator: (String text) {
                      if (text.isEmpty) {
                        return "Please provide a valid quantity";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _quantityLimit,
                    keyboardType: TextInputType.number,
                    style: kTextFieldStyle.copyWith(color: Colors.black),
                    cursorColor: kPrimaryColor,
                    decoration: k2TextFieldDecoration.copyWith(
                      labelText: "Quantity Limit",
                      labelStyle: GoogleFonts.roboto(
                          color: kPrimaryColor, fontSize: tm * 2.0),
                    ),
                    validator: (String text) {
                      if (text.isEmpty) {
                        return "Please provide a valid quantity limit";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _brand,
                    keyboardType: TextInputType.text,
                    style: kTextFieldStyle.copyWith(color: Colors.black),
                    cursorColor: kPrimaryColor,
                    decoration: k2TextFieldDecoration.copyWith(
                      labelText: "Brand",
                      labelStyle: GoogleFonts.roboto(
                          color: kPrimaryColor, fontSize: tm * 2.0),
                    ),
                    validator: (String text) {
                      if (text.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    minLines: 2,
                    maxLines: 4,
                    controller: _description,
                    keyboardType: TextInputType.multiline,
                    style: kTextFieldStyle.copyWith(color: Colors.black),
                    cursorColor: kPrimaryColor,
                    decoration: k2TextFieldDecoration.copyWith(
                      labelText: "Description (Optional)",
                      labelStyle: GoogleFonts.roboto(
                          color: kPrimaryColor, fontSize: tm * 2.0),
                    ),
                    validator: (String text) {
                      if (text.isEmpty) {
                        return "Please provide a valid description for the product";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Text(
                    "Add Picture",
                    style: TextStyle(
                        fontSize: tm * 2.2, fontWeight: FontWeight.w900),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: addImageButton(
                            imageFile: image1,
                            onPress: () {
                              takeImage(context, image: "image1");
                            },
                            imgBool: im1),
                      ),
                      Expanded(
                        child: addImageButton(
                          imageFile: image2,
                          onPress: () {
                            im1
                                ? takeImage(context, image: "image2")
                                : _imageErr(
                                    message: "You have to set Image 1 first");
                          },
                          imgBool: im2,
                        ),
                      ),
                      Expanded(
                        child: addImageButton(
                            imageFile: image3,
                            onPress: () {
                              im2
                                  ? takeImage(context, image: "image3")
                                  : _imageErr(
                                      message: "You have to set Image 2 first");
                            },
                            imgBool: im3),
                      ),
                      Expanded(
                          child: addImageButton(
                              imageFile: image4,
                              onPress: () {
                                im3
                                    ? takeImage(context, image: "image4")
                                    : _imageErr(
                                        message:
                                            "You have to set Image 3 first");
                              },
                              imgBool: im4)),
                      Expanded(
                        child: addImageButton(
                            imageFile: image5,
                            onPress: () {
                              im4
                                  ? takeImage(context, image: "image5")
                                  : _imageErr(
                                      message: "You have to set Image 4 first");
                            },
                            imgBool: im5),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  _vid
                      ? FlatButton.icon(
                          color: kPrimaryColor,
                          onPressed: pickVideo,
                          icon: Icon(
                            Icons.video_label,
                            color: kSecondColor,
                          ),
                          label: Text(
                            "Change Video(1 minute max)",
                            style: TextStyle(
                                color: Colors.white, fontSize: tm * 2),
                          ),
                        )
                      : FlatButton.icon(
                          color: kPrimaryColor,
                          onPressed: pickVideo,
                          icon: Icon(
                            Icons.video_label,
                            color: kSecondColor,
                          ),
                          label: Text(
                            "Add Video (Optional) 1 minute max",
                            style: TextStyle(
                                color: Colors.white, fontSize: tm * 2),
                          ),
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  CreateButtonWithIconSm(
                    title: "Add Stock",
                    onPressed: () {
                      _addStock();
                    },
                    assetLocation: "assets/img/database.png",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _addStock() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      try {
        _http.Response response = await _http.post(kAddProductUrl, headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        }, body: {
          "business_id": businessId,
          "category": _category,
          "name": _stockName.text,
          "code": _code.text,
          "unit_price": _unitPrice.text,
          "selling_price": _sellingPrice.text,
          "old_price": _oldPrice.text,
          "weight": _weight.text,
          "quantity": _quantity.text,
          "quantity_limit": _quantityLimit.text,
          "description": _description.text,
          "brand": _description.text,
          "staff": staff
        });
        clearInputFields();
        setState(() {
          _isLoading = false;
        });
        print("Your response is: ${response.body}");

        var data = json.decode(response.body);
        String status = data["status"];
        String product_id = data["product_id"];
        print("Your status is $status");
        if (status == "error") {
          Alert(
            style: kAlertStyle,
            context: context,
            type: AlertType.error,
            title: "Error",
            desc: "Check your internet connection",
            buttons: [
              DialogButton(
                child: Text(
                  "cancel",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                color: kSecondColor,
              ),
            ],
          ).show();
        } else if (status == "success") {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Text(
                    "Product added successfully",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.check_circle, color: Colors.green),
                )
              ],
            ),
            duration: Duration(seconds: 3),
          ));

          setState(() {
            productId = product_id;
          });
          uploadFiles(productId);
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print(e.toString());
        Alert(
          style: kAlertStyle,
          context: context,
          type: AlertType.error,
          title: "Error",
          desc: "Check your internet connection\n ${e.toString()}",
          buttons: [
            DialogButton(
              child: Text(
                "cancel",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: kSecondColor,
            ),
          ],
        ).show();
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Text(
                "Product added successfully",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(Icons.check_circle, color: Colors.green),
            )
          ],
        ),
        duration: Duration(seconds: 3),
      ));
    }
  }

  uploadFiles(String product_id) async {
    notification.showStartNotification();
    setState(() {
      _isUploadingFiles = true;
    });
    var request = _http.MultipartRequest(
      'POST',
      Uri.parse(kUploadProductFilesUrl),
    );

    request.fields['product_id'] = product_id;

    if (image1 != null) {
      request.files
          .add(await _http.MultipartFile.fromPath("Image1", image1.path));
    }
    if (image2 != null) {
      request.files.add(
        await _http.MultipartFile.fromPath('Image2', image2.path),
      );
    }
    if (image3 != null) {
      request.files.add(
        await _http.MultipartFile.fromPath('Image3', image3.path),
      );
    }
    if (image4 != null) {
      request.files.add(
        await _http.MultipartFile.fromPath('Image4', image4.path),
      );
    }
    if (image5 != null) {
      request.files.add(
        await _http.MultipartFile.fromPath('Image2', image5.path),
      );
      if (_video != null) {
        request.files.add(
          await _http.MultipartFile.fromPath('video', _video.path),
        );
      }
      clearFileFields();
      await request.send().then((response) {
        print("The status code is: ${response.statusCode}");
        if (response.statusCode == 200) {
          setState(() {
            _isUploadingFiles = false;
          });
          notification.showNotificationWithSound(productId);
        }
      });
    }
  }

  takeImage(mContext, {String image}) async {
    await showDialog(
        context: mContext,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              "Capture Image",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              SimpleDialogOption(
                child: Text(
                  "Capture Image with Camera",
                ),
                onPressed: () {
                  captureImageWithCamera(image: image);
                },
              ),
              Divider(),
              SimpleDialogOption(
                child: Text(
                  "Select Image from Gallery",
                ),
                onPressed: () {
                  selectImageFromGallery(image: image);
                },
              ),
              Divider(),
              SimpleDialogOption(
                child: Text(
                  "Cancel",
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        });
  }

  captureImageWithCamera({String image}) async {
    Navigator.pop(context);
    PickedFile picked = await picker.getImage(source: ImageSource.camera);
    File imageFile = File(picked.path);
    switch (image) {
      case 'image1':
        image1 = imageFile;
        im1 = true;
        break;
      case 'image2':
        image2 = imageFile;
        im2 = true;
        break;
      case 'image3':
        image3 = imageFile;
        im3 = true;
        break;
      case 'image4':
        image4 = imageFile;
        im4 = true;
        break;
      case 'image5':
        image5 = imageFile;
        im5 = true;
        break;
    }
    setState(() {});
  }

  selectImageFromGallery({String image}) async {
    Navigator.pop(context);
    PickedFile picked = await picker.getImage(source: ImageSource.gallery);
    File imageFile = File(picked.path);
    switch (image) {
      case 'image1':
        image1 = imageFile;
        im1 = true;
        break;
      case 'image2':
        image2 = imageFile;
        im2 = true;
        break;
      case 'image3':
        image3 = imageFile;
        im3 = true;
        break;
      case 'image4':
        image4 = imageFile;
        im4 = true;
        break;
      case 'image5':
        image5 = imageFile;
        im5 = true;
        break;
    }
    setState(() {});
  }

  Future pickVideo() async {
    PickedFile imageFile = await picker.getVideo(source: ImageSource.gallery);
    File _videoFile = File(imageFile.path);
    setState(() {
      _video = _videoFile;
      picko = imageFile;
      _vid = true;
    });
  }

  _imageErr({String message}) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 3),
    ));
  }

  Widget addImageButton({bool imgBool, File imageFile, Function onPress}) {
    return InkWell(
      onTap: onPress,
      child: Container(
        child: imgBool
            ? Image.file(imageFile)
            : Image.asset(
                "assets/img/plus_light.png",
                color: Colors.white,
              ),
        margin: EdgeInsets.all(im * 1.5),
        height: hm * 10.0,
        decoration: BoxDecoration(
          color: kHomePanelColor,
        ),
      ),
    );
  }
}
