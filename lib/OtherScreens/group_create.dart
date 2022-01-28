import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_media/OtherScreens/chat_skeleton.dart';
import 'package:social_media/OtherScreens/chat_skeleton_grp.dart';
import 'package:social_media/Services/user_details.dart';

import '../constants.dart';

class GroupCreate extends StatefulWidget {
  const GroupCreate({Key? key}) : super(key: key);

  @override
  _GroupCreateState createState() => _GroupCreateState();
}

class _GroupCreateState extends State<GroupCreate> {
  List<Map<String, dynamic>> membersList = [];

  @override
  void initState() {
    super.initState();
    membersList.add({
      "Name": UserDetails.name,
      "UserName": UserDetails.username,
      "UID": UserDetails.uid,
      "isAdmin": true,
      "ProfilePhotoUrl": UserDetails.profilePhotoUrl,
    });
  }

  void onResultTap(var array, int index) {
    bool isAlreadyExist = false;
    for (int i = 0; i < membersList.length; i++) {
      if (membersList[i]['UID'] == array[index]['Info']['Uid']) {
        isAlreadyExist = true;
      }
    }
    if (!isAlreadyExist) {
      setState(() {
        membersList.add({
          "Name": array[index]['Info']['Name'],
          "UserName": array[index]['Info']['Username'],
          "UID": array[index]['Info']['Uid'],
          "ProfilePhotoUrl": array[index]['Info']['ProfilePhotoUrl'],
        });
      });
    }
  }

  void onRemoveMembers(int index) {
    setState(() {
      membersList.removeAt(index);
    });
  }

  TextEditingController search = TextEditingController();
  TextEditingController grpName = TextEditingController();
  String searchField = "";
  bool showSpinner = false;

  bool resultData(List arr, int index, String _key) {
    if (arr[index]['Info']['Uid'] == UserDetails.uid) return false;
    String email = arr[index]['Info']['Name'];
    String name = arr[index]['Info']['Username'];
    email = email.toLowerCase();
    name = name.toLowerCase();
    _key = _key.toLowerCase();
    if (email.contains(_key) || name.contains(_key)) return true;
    return false;
  }

  Future<String> chatRoomId() async {
    var chatId = "";
    await FirebaseFirestore.instance.collection('ChatRooms').add({
      "GroupName": grpName.text,
      "isGroup": "Yes",
      "Admin": UserDetails.uid,
      "Message": "Group Created By ${UserDetails.username}",
      "Time": FieldValue.serverTimestamp(),
      "Members": membersList,
    }).then((value) async {
      for (int i = 0; i < membersList.length; i++) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(UserDetails.uid)
            .collection("LastChat")
            .doc(value.id)
            .set({
          "GroupName": grpName.text,
          "LastMsg": "Group Created By ${UserDetails.username}",
          "Type": "First Message",
          "Time": FieldValue.serverTimestamp(),
          "ChatRoomId": value.id,
          "IsGroup": "Yes",
        });

        await FirebaseFirestore.instance
            .collection("Users")
            .doc(membersList[i]['UID'])
            .collection("LastChat")
            .doc(value.id)
            .set({
          "GroupName": grpName.text,
          "LastMsg": "Group Created By ${UserDetails.username}",
          "Type": "First Message",
          "Time": FieldValue.serverTimestamp(),
          "ChatRoomId": value.id,
          "IsGroup": "Yes",
        });
      }
      chatId = value.id;
    });
    setState(() {
      showSpinner = false;
    });
    return chatId;
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
              height: deviceHeight,
              width: deviceWidth,
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                size: 25,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Create a Group',
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 8),
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                itemCount: membersList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      onRemoveMembers(index);
                                    },
                                    child: item2(
                                        image: membersList[index]
                                            ['ProfilePhotoUrl'],
                                        username: membersList[index]['UserName']),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Group Name : ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Lato',
                                  fontSize: 18,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                width: deviceWidth - 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.pink)),
                                child: TextField(
                                  textAlign: TextAlign.start,
                                  controller: grpName,
                                  decoration:
                                      kMessageTextFieldDecoration.copyWith(
                                    hintText: "Group Name",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Add a Member',
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
                                decoration: kMessageTextFieldDecoration.copyWith(
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
                                      color: Colors.pink,
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.height *
                                            .3,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "WE'RE SORRY",
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
                                        return (resultData(
                                                    _snap, index, searchField)) ==
                                                false
                                            ? SizedBox(height: 0)
                                            : item(
                                                image: _snap[index]['Info']
                                                    ['ProfilePhotoUrl'],
                                                name: _snap[index]['Info']
                                                    ['Name'],
                                                username: _snap[index]['Info']
                                                    ['Username'],
                                                ontap: () async {
                                                  onResultTap(_snap, index);

                                                  // Navigator.pushReplacement(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         ChatSkeleton(
                                                  //           senderUID: _snap[index]
                                                  //           ['Info']['Uid'],
                                                  //           chatRoomId: chatRoomid,
                                                  //         ),
                                                  //   ),
                                                  // );
                                                },
                                              );
                                      });
                            }),
                      ),
                    ],
                  ),
                  membersList.length <= 1
                      ? SizedBox()
                      : Positioned(
                          bottom: 40,
                          right: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              color: Colors.white,
                              onPressed: () async {
                                print("grp create button pressed");
                                if (grpName.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Enter Group Name",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  String chatRoomid = await chatRoomId();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatSkeletonGrp(
                                        chatRoomId: chatRoomid,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                ],
              )),
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
        width: MediaQuery.of(context).size.width,
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
                        fit: BoxFit.cover),
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

class item2 extends StatelessWidget {
  final String image, username;
  final Function()? ontap;

  const item2({
    Key? key,
    this.ontap,
    required this.image,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Stack(
        children: [
          username == UserDetails.username
              ? SizedBox()
              : Positioned(
                  right: 0,
                  child: Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: Center(
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(100, 94, 94, 1),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider("${image}"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.elliptical(36, 36)),
                  ),
                ),
                SizedBox(height: 2),
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
                SizedBox(height: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
