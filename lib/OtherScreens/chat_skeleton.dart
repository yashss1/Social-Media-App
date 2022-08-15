import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/DashBoard%20Screens/home.dart';
import 'package:social_media/OtherScreens/chat_messages.dart';
import 'package:social_media/OtherScreens/chat_textfield.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/constants.dart';

import 'call_screen.dart';

class ChatSkeleton extends StatefulWidget {
  const ChatSkeleton({Key? key, this.chatRoomId, this.senderUID})
      : super(key: key);

  final senderUID, chatRoomId;

  @override
  _ChatSkeletonState createState() => _ChatSkeletonState();
}

class _ChatSkeletonState extends State<ChatSkeleton> {
  List array = [];
  bool dataBhetla = false;

  Future getData() async {}

  @override
  void initState() {
    super.initState();

    getData().then((value) async {
      var _doc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.senderUID)
          .get();
      array.add(_doc);
      setState(() {
        dataBhetla = true;
      });
      print(array);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
                (route) => false);
            return Future.value(true);
          },
          child: Scaffold(
            body: dataBhetla == false
                ? Center(
                    child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.pink,
                    ),
                  ))
                : Column(
                    children: [
                      SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                        (route) => false);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 25),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      array[0]['Info']['Name'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontFamily: 'Lato',
                                          fontSize: 20,
                                          letterSpacing:
                                              0 /*percentages not used in flutter. defaulting to zero*/,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Last Seen",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontFamily: 'Lato',
                                          fontSize: 15,
                                          letterSpacing:
                                              0 /*percentages not used in flutter. defaulting to zero*/,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CallScreens(),
                                        ));
                                  },
                                  icon: const Icon(
                                    Icons.call,
                                    color: Colors.pink,
                                  ),
                                ),
                                SizedBox(width: 25),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CallScreens(),
                                        ));
                                  },
                                  icon: const Icon(
                                    Icons.video_call,
                                    color: Colors.pink,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: ChatMesssages(
                          array: array,
                          index: 0,
                          chatRoomId: widget.chatRoomId,
                        ),
                      ),
                      Container(
                        child: ChatTextField(
                          array: array,
                          index: 0,
                          chatRoomId: widget.chatRoomId,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
