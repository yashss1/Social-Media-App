import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_full_image_screen/custom_full_image_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_media/DashBoard%20Screens/search_page.dart';
import 'package:social_media/OtherScreens/profile_page.dart';
import 'package:social_media/OtherScreens/video_screen.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/model/post_model.dart';
import 'package:social_media/model/story_model.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:video_thumbnail/video_thumbnail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController post = TextEditingController();
  bool showSpinner = false;
  List<String> tags = [];

  //Creating or Updating a particular HashTag
  // HashTag Function (Add this PostId to that HasTag Document)
  Future makeHashTag(String word, String postId) async {
    word = word.substring(1);
    word = word.toLowerCase();
    print(word);
    print(postId);

    var _doc =
        await FirebaseFirestore.instance.collection("HashTags").doc(word).get();
    bool docStatus = _doc.exists;
    print(docStatus);
    if (docStatus == false) {
      await FirebaseFirestore.instance.collection("HashTags").doc(word).set({
        'Name': word,
        'Posts': FieldValue.arrayUnion([
          {
            'postId': postId,
          }
        ])
      });
    } else {
      await FirebaseFirestore.instance.collection("HashTags").doc(word).update({
        'Posts': FieldValue.arrayUnion([
          {
            'postId': postId,
          }
        ])
      });
    }
  }

  //Extracting all the Hashtags
  Future hashAdder(String value, String postId) async {
    bool hashExist = value.contains('#');
    if (hashExist) {
      List<String> splitted = value.split(" ");
      for (var item in splitted) {
        if (item.startsWith("#")) {
          String word = item.substring(0);
          await makeHashTag(word, postId);
          tags.add(word);
        }
      }
    }
    // print(tags);
  }

  void addIntoFirebase() async {
    setState(() {
      showSpinner = true;
    });

    FirebaseFirestore.instance.collection('Posts').add({
      'Name': UserDetails.name,
      'createdAt': Timestamp.now(),
      'AddedBy': UserDetails.uid,
      'Username': UserDetails.username,
      'Message': post.text,
      'NumberOfComments': 0,
      'ProfilePhotoUrl': UserDetails.profilePhotoUrl,
    }).then((value) async {
      // print(value);
      var documentId = value.id;
      await FirebaseFirestore.instance
          .collection('Posts')
          .doc(documentId)
          .update({
        'postId': documentId,
      }).then((value) async {});
      await hashAdder(post.text, documentId).then((value) {
        setState(() {
          showSpinner = false;
          post.clear();
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Post Added",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
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

  //STATUS
  bool showSpinner1 = false;

  Future pickVideo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4'],
    );
    if (result == null) return null;
    final pickedVideo = File(result.paths.first!);
    print(pickedVideo);

    setState(() {
      showSpinner1 = true;
    });

    // //Get the Thumbnail
    // final thumbnail = await VideoThumbnail.thumbnailData(
    //   video: pickedVideo.path,
    //   imageFormat: ImageFormat.JPEG,
    //   maxWidth: 128,
    //   // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
    //   quality: 25,
    // );
    // print(thumbnail);

    //Upload
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    String Time = "${time}";
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('StatusVideo')
        .child('$Time');

    await ref.putFile(pickedVideo);
    String videoUrl = await ref.getDownloadURL();
    print(videoUrl);

    //Now putting in Firestore
    FirebaseFirestore.instance.collection('Status').add({
      'createdAt': Timestamp.now(),
      'AddedBy': UserDetails.uid,
      'Username': UserDetails.username,
      'VideoUrl': videoUrl,
      'ProfilePhotoUrl': UserDetails.profilePhotoUrl,
      'BgPhotoUrl': UserDetails.bgPhotoUrl,
    }).then((value) async {
      // print(value);
      var documentId = value.id;
      await FirebaseFirestore.instance
          .collection('Status')
          .doc(documentId)
          .update({
        'statusId': documentId,
      }).then((value) async {});
      await hashAdder(post.text, documentId).then((value) {
        setState(() {
          showSpinner1 = false;
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Status Added",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      splashColor: Colors.pink,
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: const Icon(
                        Icons.notes,
                        size: 28,
                      ),
                    ),
                    const Text(
                      'Signature',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 79, 90, 1),
                          fontFamily: 'Lato',
                          fontSize: 23,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.notifications_none,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Container(
                            width: 34.14285659790039,
                            height: 32.590911865234375,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(196, 196, 196, 1),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      "${UserDetails.profilePhotoUrl}"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.all(Radius.elliptical(
                                  34.14285659790039, 32.590911865234375)),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await pickVideo();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 11),
                                    width: 90,
                                    height: 140,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 125,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              border: Border.all(
                                                  color: Colors.pink),
                                              color: Colors.white),
                                          child: showSpinner1 == true
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 3.0,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Colors.pink,
                                                    ),
                                                  ),
                                                )
                                              : Center(
                                                  child: Icon(
                                                  Icons.add,
                                                  color: pink,
                                                  size: 30,
                                                )),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  100, 94, 94, 1),
                                              image: DecorationImage(
                                                  image: CachedNetworkImageProvider(
                                                      "${UserDetails.profilePhotoUrl}"),
                                                  fit: BoxFit.cover),
                                              borderRadius: const BorderRadius
                                                      .all(
                                                  Radius.elliptical(36, 36)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 160,
                                  child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('Status')
                                          .orderBy('createdAt',
                                              descending: true)
                                          .snapshots(),
                                      builder: (ctx,
                                          AsyncSnapshot
                                              notificationsSnapshots) {
                                        if (notificationsSnapshots
                                                .connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        final list =
                                            notificationsSnapshots.data!.docs;
                                        print(list);
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics: BouncingScrollPhysics(),
                                          itemCount: list.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        VideoScreen(
                                                      url: list[index]
                                                          ['VideoUrl'],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Story1(
                                                  bg: list[index]['BgPhotoUrl'],
                                                  img: list[index]
                                                      ['ProfilePhotoUrl']),
                                            );
                                          },
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   physics: BouncingScrollPhysics(),
                        //   child: Row(
                        //     children: [
                        //       InkWell(
                        //         onTap: () {
                        //           Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //               builder: (context) => VideoScreen(),
                        //             ),
                        //           );
                        //         },
                        //         child: Story1(
                        //             stry: 'assets/images/Rectangle16.png',
                        //             img: 'assets/images/Rectangle12.png'),
                        //       ),
                        //
                        //       Story1(
                        //           stry: 'assets/images/Rectangle17.png',
                        //           img: 'assets/images/Rectangle13.png'),
                        //       Story1(
                        //           stry: 'assets/images/Rectangle18.png',
                        //           img: 'assets/images/Rectangle14.png'),
                        //       Story1(
                        //           stry: 'assets/images/Rectangle19.png',
                        //           img: 'assets/images/Rectangle15.png'),
                        //       Story1(
                        //           stry: 'assets/images/Rectangle20.png',
                        //           img: 'assets/images/Rectangle14.png'),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: 25),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          width: deviceWidth,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            border: Border.all(
                              color: const Color.fromRGBO(0, 0, 0, 1),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                          left: 20,
                                          right: 50,
                                          top: 15,
                                          bottom: 15),
                                      width: 52,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(100, 94, 94, 1),
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                "${UserDetails.profilePhotoUrl}"),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(52, 52)),
                                      )),
                                  Container(
                                    width: deviceWidth * .55,
                                    child: TextField(
                                      controller: post,
                                      textAlign: TextAlign.left,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        hintText: "Something in your mind",
                                      ),
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              0, 0, 0, 0.4699999988079071),
                                          fontFamily: 'Lato',
                                          fontSize: 18,
                                          letterSpacing:
                                              0 /*percentages not used in flutter. defaulting to zero*/,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 25),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (post.text == null ||
                                      post.text.length == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Please Write a Post",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    );
                                  } else {
                                    setState(() {});
                                    addIntoFirebase();
                                  }
                                },
                                child: Container(
                                  width: 107,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                    color: Color.fromRGBO(
                                        255, 79, 90, 0.800000011920929),
                                  ),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Publish',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          fontFamily: 'Lato',
                                          fontSize: 20,
                                          letterSpacing:
                                              0 /*percentages not used in flutter. defaulting to zero*/,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                    return Column(
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
                                                    child: PopupMenuButton(
                                                      onSelected: (item) =>
                                                          handleClick(
                                                              0,
                                                              list[index]
                                                                  ['postId']),
                                                      itemBuilder: (context) =>
                                                          [
                                                        PopupMenuItem<int>(
                                                            value: 0,
                                                            child:
                                                                Text('Delete')),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // return Container();
  }
}
