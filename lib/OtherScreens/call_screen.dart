import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

class CallScreens extends StatefulWidget {
  const CallScreens({Key? key}) : super(key: key);

  @override
  State<CallScreens> createState() => _CallScreensState();
}

class _CallScreensState extends State<CallScreens> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Fluttertoast.showToast(
        msg: "Unable to Connect to Server..",
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      // body: Container(
      //   height: deviceHeight,
      //   width: deviceWidth,
      //   child: Column(
      //     children: [
      //       Center(
      //         child: Container(
      //           color: Colors.white,
      //           width: MediaQuery.of(context).size.width,
      //           padding: EdgeInsets.only(
      //             top: MediaQuery.of(context).size.height * .3,
      //           ),
      //           child: Column(
      //             children: [
      //               Text(
      //                 "WE'RE SORRY",
      //                 style: TextStyle(color: pink, fontSize: 35),
      //               ),
      //               Center(
      //                 child: Text(
      //                   "Live API to Server not Connected",
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(color: pink, fontSize: 20),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       SizedBox(height: deviceHeight * .1),
      //       InkWell(
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //         child: Container(
      //           height: deviceWidth * .1,
      //           width: deviceWidth * .5,
      //           decoration: BoxDecoration(
      //               color: pink, borderRadius: BorderRadius.circular(20)),
      //           child: Center(
      //             child: Text(
      //               'Go Back',
      //               style: TextStyle(fontSize: 25, color: Colors.white),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Container(),
    );
  }
}
