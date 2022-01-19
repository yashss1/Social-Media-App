import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_media/Services/authentication_helper.dart';
import 'package:social_media/Services/get_user_data.dart';
import 'package:social_media/model/button1.dart';

import '../constants.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool showSpinner = false;

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
                            width: deviceWidth * .30,
                          ),
                          const Text(
                            'Reset Password',
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
                    TextField(
                      textAlign: TextAlign.center,
                      controller: email,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: "Email",
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.015),
                    // TextField(
                    //   obscureText: true, //For hidden text for password
                    //   textAlign: TextAlign.center,
                    //   controller: password,
                    //   decoration: kTextFieldDecoration.copyWith(
                    //     hintText: "Password",
                    //   ),
                    // ),

                    SizedBox(height: deviceHeight * 0.05),
                    InkWell(
                      onTap: () async {
                        if (email.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Enter Email",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            showSpinner = true;
                          });
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email.text)
                              .then(
                                (result) {
                                setState(() {
                                  showSpinner = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Reset Link sent to ${email.text}",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                );
                                Navigator.pop(context);
                            },
                          );
                        }
                      },
                      child: Button1(
                        name: 'Send Request',
                        width: deviceWidth * 0.9,
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.05),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: const [
                    //     Text(
                    //       'OR',
                    //       textAlign: TextAlign.left,
                    //       style: TextStyle(
                    //           color: Color.fromRGBO(0, 0, 0, 1),
                    //           fontFamily: 'Lato',
                    //           fontSize: 18,
                    //           letterSpacing:
                    //               0 /*percentages not used in flutter. defaulting to zero*/,
                    //           fontWeight: FontWeight.bold,
                    //           height: 1),
                    //     )
                    //   ],
                    // ),
                    SizedBox(height: deviceHeight * 0.08),
                    // // Padding(
                    // //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    // //   child: Row(
                    // //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // //     children: const [
                    // //       IconButton1(icons: 'assets/images/fb_icon.png'),
                    // //       IconButton1(icons: 'assets/images/google_icon.png'),
                    // //     ],
                    // //   ),
                    // ),
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
