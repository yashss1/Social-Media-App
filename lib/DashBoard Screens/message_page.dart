import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/OtherScreens/all_user_chat.dart';
import 'package:social_media/OtherScreens/chat_skeleton.dart';
import 'package:social_media/OtherScreens/chat_skeleton_grp.dart';
import 'package:social_media/OtherScreens/group_create.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/model/recent_chat.dart';
import 'package:social_media/model/recent_chat_grp.dart';

import '../constants.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController search = TextEditingController();
  String searchField = "";

  // bool resultData(List arr, int index, String _key) {
  //   if (arr[index]['Info']['Uid'] == UserDetails.uid) return false;
  //   String email = arr[index]['Info']['Name'];
  //   String name = arr[index]['Info']['Username'];
  //   email = email.toLowerCase();
  //   name = name.toLowerCase();
  //   _key = _key.toLowerCase();
  //   if (email.contains(_key) || name.contains(_key)) return true;
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: deviceWidth,
          height: deviceHeight,
          child: Stack(
            children: [
              Container(
                  height: deviceHeight,
                  width: deviceWidth,
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Recent Messages',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Lato',
                                  fontSize: 23,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        width: deviceWidth,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          color:
                              Color.fromRGBO(226, 226, 226, 0.3199999928474426),
                          border: Border.all(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: deviceWidth - 100,
                              child: TextField(
                                textAlign: TextAlign.start,
                                controller: search,
                                onChanged: (text) {
                                  setState(() {
                                    searchField = text;
                                    // print(searchField);
                                  });
                                },
                                decoration:
                                    kMessageTextFieldDecoration.copyWith(
                                  hintText: "Search",
                                ),
                              ),
                            ),
                            Container(
                              width: 55,
                              height: 55,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(
                                          0, 0, 0, 0.14000000059604645),
                                      offset: Offset(1, 1),
                                      blurRadius: 12)
                                ],
                                color: Color.fromRGBO(255, 79, 90, 1),
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Expanded(
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('Users')
                                .doc(UserDetails.uid)
                                .collection('LastChat')
                                .orderBy("Time", descending: true)
                                .snapshots(),
                            builder: (ctx, AsyncSnapshot snaps) {
                              if (snaps.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final _snap = snaps.data!.docs;
                              return _snap.length == 0
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                .3,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "No Recent Chats",
                                          ),
                                          Center(
                                            child: Text(
                                              "There is Nothing here...",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: _snap.length,
                                      itemBuilder: (context, index) {
                                        return _snap[index]['IsGroup'] == "Yes"
                                            ? RecentChatGrp(
                                                ontap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatSkeletonGrp(
                                                        chatRoomId: _snap[index]
                                                            ['ChatRoomId'],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                lastMsg: _snap[index]
                                                    ['LastMsg'],
                                                grpName: _snap[index]
                                                    ['GroupName'],
                                                chatRoomId: _snap[index]
                                                    ['ChatRoomId'])
                                            : RecentChat(
                                                uid: _snap[index]['ChatWith'],
                                                lastMsg: _snap[index]
                                                    ['LastMsg'],
                                                ontap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatSkeleton(
                                                        senderUID: _snap[index]
                                                            ['ChatWith'],
                                                        chatRoomId: _snap[index]
                                                            ['ChatRoomId'],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                      });
                            }),
                      ),
                    ],
                  )),
              Positioned(
                bottom: 100,
                right: 30,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllUserChatPage(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.group_add),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupCreate(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class item extends StatelessWidget {
  final String image, name, username;
  final Function()? ontap;

  const item({
    Key? key,
    this.ontap,
    required this.image,
    required this.name,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        // width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(100, 94, 94, 1),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider("${image}"),
                        fit: BoxFit.fitWidth),
                    borderRadius: BorderRadius.all(Radius.elliptical(36, 36)),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${name}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Lato',
                          fontSize: 17,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '@${username}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.8100000023841858),
                          fontFamily: 'Lato',
                          fontSize: 15,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
