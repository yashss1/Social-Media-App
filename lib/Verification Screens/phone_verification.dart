import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/Verification%20Screens/phone_verification2.dart';
import 'package:social_media/model/button1.dart';
import '../constants.dart';

class PhoneVerify extends StatefulWidget {
  const PhoneVerify({Key? key}) : super(key: key);

  @override
  _PhoneVerifyState createState() => _PhoneVerifyState();
}

class _PhoneVerifyState extends State<PhoneVerify> {
  TextEditingController phone_number = TextEditingController();
  String dialCode = "+1";
  bool showSpinner = false, flag = true;

  Future getData(String phone) async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('Users').get();
    final List<DocumentSnapshot> documents = result.docs;

    // Iterate through all the Documents
    documents.forEach((data) {
      bool docStatus = data.exists;
      if (docStatus == true) {
        if (data['Info']['PhoneNumber'] == phone) {
          setState(() {
            flag = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: deviceHeight,
          width: deviceWidth,
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      width: deviceWidth,
                      height: 70,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            splashColor: Colors.pink,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              size: 28,
                            ),
                          ),
                          SizedBox(
                            width: deviceWidth * .20,
                          ),
                          const Text(
                            'Phone Verification',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromRGBO(255, 79, 90, 1),
                                fontFamily: 'Lato',
                                fontSize: 20,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: deviceHeight * .1),
                    Container(
                      height: 60,
                      width: deviceWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10.0),
                              border:
                                  Border.all(color: Colors.grey, width: 1.0),
                            ),
                            child: CountryCodePicker(
                              onChanged: (c) {
                                dialCode = c.dialCode!;
                              },
                              initialSelection: 'US',
                              favorite: ['+1', 'US'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                              flagDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.left,
                              controller: phone_number,
                              keyboardType: TextInputType.number,
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: "55555 55555",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.05),
                    InkWell(
                      onTap: () async {
                        if (phone_number.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Enter Phone Number",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            showSpinner = true;
                          });
                          flag = true;
                          await getData("$dialCode${phone_number.text}")
                              .then((value) {
                            if (flag == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PhoneVerify2(
                                            phone:
                                                "$dialCode${phone_number.text}",
                                          )));
                            } else {
                              setState(() {
                                showSpinner = false;
                              });
                              print("PhoneNumber already present");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Phone Number Already Registered",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              );
                            }
                          });
                        }
                      },
                      child: Button1(
                        name: 'Send OTP',
                        width: deviceWidth * 0.9,
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.05),
                    SizedBox(height: deviceHeight * 0.08),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
