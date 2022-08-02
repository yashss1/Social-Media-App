import 'package:flutter/material.dart';
import '../DashBoard Screens/home_page.dart';
import '../constants.dart';
import '../textfield.dart';

class ThankYouP extends StatefulWidget {
  const ThankYouP({Key? key}) : super(key: key);

  @override
  _ThankYouPState createState() => _ThankYouPState();
}

class _ThankYouPState extends State<ThankYouP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        size: 50,
                      ),
                    ),
                    alignment: Alignment.topRight,
                  ),
                  SizedBox(height: 120),
                  Text("THANK", style: myStyle(55, "Syne", color: pink)),
                  Text("YOU", style: myStyle(55, "Syne", color: pink)),
                  SizedBox(height: 20),
                  Text(
                    'Your Listing has been posted.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Syne',
                        fontSize: 20,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                  SizedBox(height: 60),
                  Container(
                      width: 176,
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Whitelogo1.png'),
                            fit: BoxFit.fitWidth),
                      )),
                  SizedBox(height: 80),
                  Container(
                    alignment: Alignment.center,
                    child: button(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                          (route) => false),
                      child: Text("GO HOME"),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
