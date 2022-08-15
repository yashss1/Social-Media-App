import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_media/OtherScreens/add_video.dart';
import 'package:social_media/model/video_model.dart';

import '../Services/user_details.dart';
import '../constants.dart';

class Videos extends StatefulWidget {
  const Videos({Key? key}) : super(key: key);

  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  bool showSpinner = false;

  deleteVideo(String postId) async {
    // print("Delete Post button pressed");
    setState(() {
      showSpinner = true;
    });
    Navigator.pop(context);

    //Deleting Likes Collection
    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    var collection =
        instance.collection('VideoPost').doc(postId).collection("Likes");
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();

    //Deleting Likes Collection
    final instance2 = FirebaseFirestore.instance;
    final batch2 = instance2.batch();
    var collection2 =
        instance2.collection('VideoPost').doc(postId).collection("Comments");
    var snapshots2 = await collection2.get();
    for (var doc in snapshots2.docs) {
      batch2.delete(doc.reference);
    }
    await batch2.commit();

    // Deleting the Post Document
    await FirebaseFirestore.instance
        .collection("VideoPost")
        .doc(postId)
        .delete();
    setState(() {
      showSpinner = false;
    });
  }

  void handleClick(int item, String videoId) async {
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
                      "Are you Sure you want to delete this Video ?",
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
                              await deleteVideo(videoId);
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

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddVideo()));
          },
          child: Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(shape: BoxShape.circle, color: pink),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            width: deviceWidth,
            height: deviceHeight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: deviceWidth,
                    height: 70,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              splashColor: Colors.pink,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                size: 28,
                              ),
                            ),
                            SizedBox(width: 25),
                            const Text(
                              'Videos',
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
                        Row(
                          children: const [
                            Icon(
                              Icons.search,
                              size: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('VideoPost')
                            .orderBy('createdAt', descending: true)
                            .snapshots(),
                        builder: (ctx, AsyncSnapshot notificationsSnapshots) {
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
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      VideoModel(
                                        array: list,
                                        index: index,
                                      ),
                                      UserDetails.uid == list[index]['AddedBy']
                                          ? Positioned(
                                              top: 5,
                                              right: 10,
                                              child: PopupMenuButton(
                                                onSelected: (item) =>
                                                    handleClick(0,
                                                        list[index]['videoId']),
                                                itemBuilder: (context) => [
                                                  PopupMenuItem<int>(
                                                      value: 0,
                                                      child: Text('Delete')),
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
                  // Expanded(
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 16),
                  //     child: SingleChildScrollView(
                  //       physics: BouncingScrollPhysics(),
                  //       child: Column(
                  //         children: [
                  //           SizedBox(height: 30),
                  //           VideoModel(
                  //               user_name: 'Justin Flom',
                  //               views: '111M',
                  //               caption: 'It spilled Everywhere',
                  //               img: 'assets/images/Rectangle91(1).png',
                  //               user_dp: 'assets/images/Ellipse111.png',
                  //               date: 'Aug 1'),
                  //           VideoModel(
                  //               user_name: 'Yash Sonawane',
                  //               views: '521M',
                  //               caption: 'You should Study Always',
                  //               img: 'assets/images/Rectangle105.png',
                  //               user_dp: 'assets/images/Rectangle36(1).png',
                  //               date: 'Jan 8'),
                  //           VideoModel(
                  //               user_name: 'Maria Chan',
                  //               views: '123K',
                  //               caption: 'What should I write here',
                  //               img: 'assets/images/Rectangle91(1).png',
                  //               user_dp: 'assets/images/Ellipse129.png',
                  //               date: 'Aug 10'),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
