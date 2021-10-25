import 'package:flutter/material.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/model/button1.dart';
import 'package:social_media/model/icon_button.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

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
                hintText: "Full Name",
              ),
            ),
            SizedBox(height: deviceHeight * 0.015),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: "UserName",
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
            TextField(
              obscureText: true, //For hidden text for password
              textAlign: TextAlign.center,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: "Confirm Password",
              ),
            ),
            SizedBox(height: deviceHeight * 0.05),
            Button1(name: 'REGISTER', width: deviceWidth * 0.9),
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
            SizedBox(height: deviceHeight * 0.06),
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
