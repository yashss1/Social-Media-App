import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_media/Services/authentication_helper.dart';
import 'package:social_media/Services/store_user_info.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/model/button1.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: deviceHeight * 0.05),
              TextField(
                controller: fullName,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Full Name",
                ),
              ),
              SizedBox(height: deviceHeight * 0.015),
              TextField(
                controller: userName,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "UserName",
                ),
              ),
              SizedBox(height: deviceHeight * 0.015),
              TextField(
                controller: email,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Email",
                ),
              ),
              SizedBox(height: deviceHeight * 0.015),
              TextField(
                controller: password,
                obscureText: true, //For hidden text for password
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Password",
                ),
              ),
              SizedBox(height: deviceHeight * 0.05),
              InkWell(
                onTap: () {
                  if (fullName.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Enter Full Name",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  } else if (userName.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Enter User Name",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  } else if (email.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Enter Email",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  } else if (password.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Enter PassWord",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  } else {
                    setState(() {
                      showSpinner = true;
                    });
                    AuthenticationHelper()
                        .signUp(email: email.text, password: password.text)
                        .then(
                      (result) {
                        if (result == null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StoreRegisterData(
                                name: fullName.text,
                                username: userName.text,
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            showSpinner = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                result,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }
                },
                child: Button1(
                  name: 'REGISTER',
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
              SizedBox(height: deviceHeight * 0.06),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: const [
              //       IconButton1(icons: 'assets/images/fb_icon.png'),
              //       IconButton1(icons: 'assets/images/google_icon.png'),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
