import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_media/DashBoard%20Screens/home.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/model/post_model.dart';

import '../constants.dart';

class IndividualHashtag1 extends StatefulWidget {
  const IndividualHashtag1({Key? key, this.hashtag}) : super(key: key);

  final hashtag;

  @override
  _IndividualHashtag1State createState() => _IndividualHashtag1State();
}

class _IndividualHashtag1State extends State<IndividualHashtag1> {
  List postList = [];
  bool showSpinner = true;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('HashTags')
        .doc(widget.hashtag)
        .get()
        .then((value) {
      postList = value['Posts'];
      setState(() {
        showSpinner = false;
      });
    });
  }

  deletePost(String postId) async {
    // print("Delete Post button pressed");
    setState(() {
      showSpinner = true;
    });
    Navigator.pop(context);

    //Deleting Likes Collection
    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    var collection =
        instance.collection('Posts').doc(postId).collection("Likes");
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();

    //Deleting Likes Collection
    final instance2 = FirebaseFirestore.instance;
    final batch2 = instance2.batch();
    var collection2 =
        instance2.collection('Posts').doc(postId).collection("Comments");
    var snapshots2 = await collection2.get();
    for (var doc in snapshots2.docs) {
      batch2.delete(doc.reference);
    }
    await batch2.commit();

    // Deleting the Post Document
    await FirebaseFirestore.instance.collection("Posts").doc(postId).delete();
    setState(() {
      showSpinner = false;
    });
  }

  void handleClick(int item, String postId) async {
    switch (item) {
      case 0:
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * .7,
                height: 160,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Confirmation",
                          style: TextStyle(
                              color: pink,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Are you Sure you want to delete this Post ?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          InkWell(
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            onTap: () async {
                              await deletePost(postId);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
        break;
    }
  }

  //Hashtags
  bool isPresent(String postId) {
    for (int i = 0; i < postList.length; i++) {
      if (postList[i]['postId'] == postId) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
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
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Container(
              width: deviceWidth,
              height: deviceHeight,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: deviceWidth,
                    height: 70,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          splashColor: Colors.pink,
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                                    (route) => false);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            size: 28,
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth * .30,
                        ),
                        Text(
                          '#${widget.hashtag}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 79, 90, 1),
                              fontFamily: 'Lato',
                              fontSize: 20,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: 25),
                          Container(
                            height: MediaQuery.of(context).size.height,
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('Posts')
                                    .orderBy('createdAt', descending: true)
                                    .snapshots(),
                                builder:
                                    (ctx, AsyncSnapshot notificationsSnapshots) {
                                  if (notificationsSnapshots.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  final list = notificationsSnapshots.data!.docs;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> mp = {
                                        "postId": list[index]['postId']
                                      };
                                      print(postList);
                                      print(mp);
                                      print(postList.contains(mp));
                                      return isPresent(list[index]['postId']) ==
                                              false
                                          ? Container()
                                          : Column(
                                              children: [
                                                Stack(
                                                  children: [
                                                    PostModel(
                                                      array: list,
                                                      index: index,
                                                    ),
                                                    UserDetails.uid ==
                                                            list[index]['AddedBy']
                                                        ? Positioned(
                                                            top: 5,
                                                            right: 10,
                                                            child:
                                                                PopupMenuButton(
                                                              onSelected: (item) =>
                                                                  handleClick(
                                                                      0,
                                                                      list[index][
                                                                          'postId']),
                                                              itemBuilder:
                                                                  (context) => [
                                                                PopupMenuItem<
                                                                        int>(
                                                                    value: 0,
                                                                    child: Text(
                                                                        'Delete')),
                                                              ],
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                                if (index == list.length - 1)
                                                  SizedBox(height: 80),
                                              ],
                                            );
                                    },
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
