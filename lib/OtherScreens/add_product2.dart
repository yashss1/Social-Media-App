import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_media/DashBoard%20Screens/home.dart';
import 'package:social_media/DashBoard%20Screens/home_page.dart';
import 'package:social_media/OtherScreens/thank_you.dart';

import '../Services/user_details.dart';
import '../constants.dart';
import '../textfield.dart';

class AddProduct2 extends StatefulWidget {
  const AddProduct2({
    Key? key,
    required this.brand,
    required this.item,
    required this.detail,
    required this.price,
  }) : super(key: key);

  final String brand, item, detail, price;

  @override
  _AddProduct2State createState() => _AddProduct2State();
}

class _AddProduct2State extends State<AddProduct2> {
  bool showSpinner = false;

  //Photos
  late File _pickedImage;
  var isPicked = false;
  int total_picked = 0;

  void _pickImage() async {
    ImagePicker imagePicker = new ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    // await _cropImage1(pickedImageFile!.path);
    setState(() {
      total_picked++;
      _pickedImage = File(pickedImageFile!.path);
      isPicked = true;
    });
  }

  late File _pickedImage2;
  var isPicked2 = false;

  void _pickImage2() async {
    ImagePicker imagePicker = new ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    setState(() {
      total_picked++;
      _pickedImage2 = File(pickedImageFile!.path);
      isPicked2 = true;
    });
  }

  late File _pickedImage3;
  var isPicked3 = false;

  void _pickImage3() async {
    ImagePicker imagePicker = new ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    setState(() {
      total_picked++;
      _pickedImage3 = File(pickedImageFile!.path);
      isPicked3 = true;
    });
  }

  late File _pickedImage4;
  var isPicked4 = false;

  void _pickImage4() async {
    ImagePicker imagePicker = new ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    setState(() {
      total_picked++;
      _pickedImage4 = File(pickedImageFile!.path);
      isPicked4 = true;
    });
  }

  String imageUrl = "Null";
  String imageUrl2 = "Null";
  String imageUrl3 = "Null";
  String imageUrl4 = "Null";

  void addIntoFirebase() async {
    setState(() {
      showSpinner = true;
    });

    //Uploading Images
    if (isPicked) {
      var time = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('ShopItems')
          .child('$time');

      await ref.putFile(_pickedImage);
      imageUrl = await ref.getDownloadURL();
    }
    if (isPicked2) {
      var time = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('ShopItems')
          .child('$time');

      await ref.putFile(_pickedImage2);
      imageUrl2 = await ref.getDownloadURL();
    }
    if (isPicked3) {
      var time = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('ShopItems')
          .child('$time');

      await ref.putFile(_pickedImage3);
      imageUrl3 = await ref.getDownloadURL();
    }
    if (isPicked4) {
      var time = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('ShopItems')
          .child('$time');

      await ref.putFile(_pickedImage4);
      imageUrl4 = await ref.getDownloadURL();
    }

    var _doc = await FirebaseFirestore.instance
        .collection("Shop")
        .doc(UserDetails.uid)
        .get();
    bool docStatus = _doc.exists;

    List<String> imgList = [imageUrl, imageUrl2, imageUrl3, imageUrl4];
    // String imgList = "";

    // print(docStatus);
    if (docStatus == false) {
      FirebaseFirestore.instance.collection('Shop').doc(UserDetails.uid).set({
        'Items': FieldValue.arrayUnion([
          {
            'Type': "Items",
            'UserName': UserDetails.name,
            'UID': UserDetails.uid,
            'BrandName': widget.brand,
            'ItemName': widget.item,
            'Price': widget.price,
            'Details': widget.detail,
            'Images': imgList,
            'createdAt': Timestamp.now(),
          }
        ])
      }).then((value) {
        setState(() {
          showSpinner = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Item Added",
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      });
    } else {
      FirebaseFirestore.instance
          .collection('Shop')
          .doc(UserDetails.uid)
          .update({
        'Items': FieldValue.arrayUnion([
          {
            'Type': "Items",
            'UserName': UserDetails.name,
            'UID': UserDetails.uid,
            'BrandName': widget.brand,
            'ItemName': widget.item,
            'Price': widget.price,
            'Details': widget.detail,
            'Images': imgList,
            'createdAt': Timestamp.now(),
          }
        ])
      }).then((value) {
        setState(() {
          showSpinner = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Item Added",
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [
            //       Color(0xff1F00FC),
            //       Colors.black,
            //       Colors.black,
            //     ],
            //   ),
            // ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 70),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.arrow_back, size: 30, color: pink),
                        ),
                      ),
                      Center(
                          child: Text(
                        'Add Images',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: pink,
                            fontFamily: 'Syne',
                            fontSize: 25,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      )),
                    ],
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Center(
                              child: Text(
                            'Upload upto 4 Images for your Product',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Syne',
                                fontSize: 20,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          )),
                          SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  _pickImage();
                                },
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    height: 181.4901885986328,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(25),
                                      ),
                                      gradient: LinearGradient(
                                          begin: Alignment(
                                              -2.735211000005005e-16,
                                              1.123778223991394),
                                          end: Alignment(-1.123778223991394,
                                              6.881157358895517e-17),
                                          colors: [
                                            Colors.grey.shade400,
                                            Colors.grey.shade200,
                                          ]),
                                      image: DecorationImage(
                                          image: isPicked
                                              ? FileImage(_pickedImage)
                                                  as ImageProvider
                                              : AssetImage(
                                                  'assets/images/Rectangle500.png'),
                                          fit: BoxFit.cover),
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  _pickImage2();
                                },
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    height: 181.4901885986328,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(25),
                                      ),
                                      gradient: LinearGradient(
                                          begin: Alignment(
                                              -2.735211000005005e-16,
                                              1.123778223991394),
                                          end: Alignment(-1.123778223991394,
                                              6.881157358895517e-17),
                                          colors: [
                                            Colors.grey.shade400,
                                            Colors.grey.shade200,
                                          ]),
                                      image: DecorationImage(
                                          image: isPicked2
                                              ? FileImage(_pickedImage2)
                                                  as ImageProvider
                                              : AssetImage(
                                                  'assets/images/Rectangle501.png'),
                                          fit: BoxFit.cover),
                                    )),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  _pickImage3();
                                },
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    height: 181.4901885986328,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(25),
                                      ),
                                      gradient: LinearGradient(
                                          begin: Alignment(
                                              -2.735211000005005e-16,
                                              1.123778223991394),
                                          end: Alignment(-1.123778223991394,
                                              6.881157358895517e-17),
                                          colors: [
                                            Colors.grey.shade400,
                                            Colors.grey.shade200,
                                          ]),
                                      image: DecorationImage(
                                          image: isPicked3
                                              ? FileImage(_pickedImage3)
                                                  as ImageProvider
                                              : AssetImage(
                                                  'assets/images/Rectangle502.png'),
                                          fit: BoxFit.cover),
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  _pickImage4();
                                },
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    height: 181.4901885986328,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(25),
                                      ),
                                      gradient: LinearGradient(
                                          begin: Alignment(
                                              -2.735211000005005e-16,
                                              1.123778223991394),
                                          end: Alignment(-1.123778223991394,
                                              6.881157358895517e-17),
                                          colors: [
                                            Colors.grey.shade400,
                                            Colors.grey.shade200,
                                          ]),
                                      image: DecorationImage(
                                          image: isPicked4
                                              ? FileImage(_pickedImage4)
                                                  as ImageProvider
                                              : AssetImage(
                                                  'assets/images/Rectangle503.png'),
                                          fit: BoxFit.cover),
                                    )),
                              )
                            ],
                          ),
                          SizedBox(height: 100),
                          Container(
                            alignment: Alignment.center,
                            child: button(
                              onPressed: () async {
                                if (isPicked ||
                                    isPicked2 ||
                                    isPicked3 ||
                                    isPicked4) {
                                  addIntoFirebase();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Please upload atleast 1 Image",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text("ADD"),

                              // ignore: prefer_const_constructors
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
