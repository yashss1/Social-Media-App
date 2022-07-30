import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/DashBoard%20Screens/home.dart';
import 'package:social_media/OtherScreens/chat_messages.dart';
import 'package:social_media/OtherScreens/chat_messages_grp.dart';
import 'package:social_media/OtherScreens/chat_textfield.dart';
import 'package:social_media/OtherScreens/chat_textfield_grp.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/constants.dart';

class ChatSkeletonGrp extends StatefulWidget {
  const ChatSkeletonGrp({Key? key, this.chatRoomId}) : super(key: key);

  final chatRoomId;

  @override
  _ChatSkeletonGrpState createState() => _ChatSkeletonGrpState();
}

class _ChatSkeletonGrpState extends State<ChatSkeletonGrp> {
  List memberList = [], array = [];
  bool dataBhetla = false;
  String grpName = "";
  int myIndex = -1;

  Future getData() async {
    var _doc = await FirebaseFirestore.instance
        .collection("ChatRooms")
        .doc(widget.chatRoomId)
        .get();

    memberList = _doc['Members'];
    grpName = _doc['GroupName'];
    print(memberList);
  }

  @override
  void initState() {
    super.initState();

    getData().then((value) async {
      for (int i = 0; i < memberList.length; i++) {
        var _doc = await FirebaseFirestore.instance
            .collection("Users")
            .doc(memberList[i]['UID'])
            .get();

        if (memberList[i]['UID'] == UserDetails.uid) {
          myIndex = i;
        }
        array.add(_doc);
      }
      setState(() {
        dataBhetla = true;
      });
      // print(array);
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
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      grpName,
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
                                      "Admin : ${memberList[0]['Name']}",
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
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.call,
                                    color: Colors.pink,
                                  ),
                                ),
                                SizedBox(width: 25),
                                IconButton(
                                  onPressed: () {},
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
                        child: ChatMesssagesGrp(
                          array: array,
                          chatRoomId: widget.chatRoomId,
                        ),
                      ),
                      Container(
                        child: ChatTextFieldGrp(
                          myIndex: myIndex,
                          grpName: grpName,
                          array: array,
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
