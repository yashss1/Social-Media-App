import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media/DashBoard%20Screens/home.dart';
import 'package:social_media/DashBoard%20Screens/home_page.dart';
import 'package:social_media/DashBoard%20Screens/user_page.dart';
import 'package:social_media/Nav%20Drawer%20Screens/signature_kids.dart';
import 'package:social_media/Verification%20Screens/verification_screen.dart';
import 'package:social_media/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
      statusBarBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Lato',
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
