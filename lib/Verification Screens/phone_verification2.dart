import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:social_media/Services/authentication_helper.dart';
import 'package:social_media/Services/get_user_data.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/model/button1.dart';
import '../constants.dart';

class PhoneVerify2 extends StatefulWidget {
  const PhoneVerify2({Key? key, required this.phone}) : super(key: key);

  final String phone;

  @override
  _PhoneVerify2State createState() => _PhoneVerify2State();
}

class _PhoneVerify2State extends State<PhoneVerify2> {
  String dialCode = "+1";
  bool showSpinner = false;

  String smsCode = "", code = "";
  String _verificationCode = "753421";
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _verifyPhone();
    print(widget.phone);
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          code = credential.smsCode!;
          print('User Phone Added');
          UserDetails.phone = widget.phone;
          print(UserDetails.phone);

        //   // await AuthenticationHelper().userPhone(phone_number.text).then(
        //   //   (result) {
        //   //     Navigator.pushReplacement(
        //   //       context,
        //   //       MaterialPageRoute(
        //   //         builder: (context) => GetUserData(),
        //   //       ),
        //   //     );
        //   //   },
        //   // );
        //   final CollectionReference userCollection =
        //       FirebaseFirestore.instance.collection('Users');
        //   FirebaseAuth auth = FirebaseAuth.instance;
        //   String uid = auth.currentUser!.uid.toString();
        //
        //   userCollection.doc(uid).set({
        //     "Info": {
        //       "PhoneNumber": widget.phone,
        //     }
        //   }, SetOptions(merge: true)).then(
        //     (value) {
        //       print("User Phone Number Added");
        //       Navigator.pushAndRemoveUntil(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => GetUserData(),
        //           ),
        //           (route) => false);
        //     },
        //   ).catchError(
        //       (error) => print("Failed to Add user Phone Number: $error"));

          await FirebaseAuth.instance.currentUser!
              .linkWithCredential(credential)
              .then((value) {
            setState(() {
              showSpinner = true;
            });
            // print(code);
            try {
              UserDetails.phone = widget.phone;
              final CollectionReference userCollection =
              FirebaseFirestore.instance
                  .collection('Users');
              FirebaseAuth auth = FirebaseAuth.instance;
              String uid = auth.currentUser!.uid.toString();

              userCollection.doc(uid).set({
                "Info": {
                  "PhoneNumber": widget.phone,
                }
              }, SetOptions(merge: true)).then(
                    (value) {
                  setState(() {
                    showSpinner = false;
                  });
                  print("User Phone Number Added");
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetUserData(),
                      ),
                          (route) => false);
                },
              ).catchError((error) => print(
                  "Failed to Add user Phone Number: $error"));
            } catch (e) {
              print(e);
              setState(() {
                showSpinner = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Invalid OTP",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              );
            }
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  error.toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          });

        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "${e.message}",
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        },
        codeSent: (String verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  Widget otpField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PinCodeTextField(
        length: 6,
        textStyle: TextStyle(fontSize: 35, color: Colors.grey),
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          activeColor: Colors.black,
          inactiveColor: Colors.grey,
          selectedColor: Colors.black,
          fieldHeight: 50,
          fieldWidth: 45,
          activeFillColor: Colors.grey.withOpacity(.4),
          borderWidth: 2,
        ),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        enableActiveFill: false,
        cursorColor: Colors.black,
        cursorHeight: 35,
        keyboardType: TextInputType.number,
        onCompleted: (v) {
          print("Completed");
        },
        onChanged: (value) {
          print(value);
          setState(() {
            smsCode = value;
          });
        },
        appContext: context,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
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
                      otpField(),
                      SizedBox(height: deviceHeight * 0.025),
                      InkWell(
                        onTap: () async {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: _verificationCode,
                                  smsCode: smsCode);
                          await FirebaseAuth.instance.currentUser!
                              .linkWithCredential(credential)
                              .then((value) {
                            setState(() {
                              showSpinner = true;
                            });
                            print(smsCode);
                            try {
                              UserDetails.phone = widget.phone;
                              final CollectionReference userCollection =
                                  FirebaseFirestore.instance
                                      .collection('Users');
                              FirebaseAuth auth = FirebaseAuth.instance;
                              String uid = auth.currentUser!.uid.toString();

                              userCollection.doc(uid).set({
                                "Info": {
                                  "PhoneNumber": widget.phone,
                                }
                              }, SetOptions(merge: true)).then(
                                (value) {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  print("User Phone Number Added");
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GetUserData(),
                                      ),
                                      (route) => false);
                                },
                              ).catchError((error) => print(
                                  "Failed to Add user Phone Number: $error"));
                            } catch (e) {
                              print(e);
                              setState(() {
                                showSpinner = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Invalid OTP",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              );
                            }
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  error.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          });

                        },
                        child: Button1(
                          name: 'Verify Phone Number',
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
      ),
    );
  }
}
