import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/DashBoard%20Screens/home.dart';
import 'package:social_media/model/button1.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/model/icon_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: deviceHeight * 0.05),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: "Email",
              ),
            ),
            SizedBox(height: deviceHeight * 0.015),
            TextField(
              obscureText: true, //For hidden text for password
              textAlign: TextAlign.center,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: "Password",
              ),
            ),
            SizedBox(height: deviceHeight * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 18,
                      height: 17,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                        border: Border.all(
                          color: const Color.fromRGBO(255, 79, 90, 1),
                          width: 1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Remember me',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Lato',
                          fontSize: 14,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    )
                  ],
                ),
                const Text(
                  'Forget password?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Lato',
                      fontSize: 14,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
              ],
            ),
            SizedBox(height: deviceHeight * 0.05),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ),
                );
              },
              child: Button1(
                name: 'LOGIN',
                width: deviceWidth * 0.9,
              ),
            ),
            SizedBox(height: deviceHeight * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'OR',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Lato',
                      fontSize: 18,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1),
                )
              ],
            ),
            SizedBox(height: deviceHeight * 0.08),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  IconButton1(icons: 'assets/images/fb_icon.png'),
                  IconButton1(icons: 'assets/images/google_icon.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
