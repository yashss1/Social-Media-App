import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_media/DashBoard%20Screens/home.dart';
import 'package:social_media/OtherScreens/profile_page.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/model/comment_mdel.dart';
import 'package:social_media/model/post_model.dart';

import '../constants.dart';

class IndividualPost extends StatefulWidget {
  const IndividualPost({Key? key, this.array, this.index, this.nComments}) : super(key: key);

  final array, index, nComments;

  @override
  _IndividualPostState createState() => _IndividualPostState();
}

class _IndividualPostState extends State<IndividualPost> {
  var list = [];
  TextEditingController comment = TextEditingController();
  bool showSpinner = false;
  int numberOfComments = 0;

  addComment() async {
    setState(() {
      showSpinner = true;
    });
    await FirebaseFirestore.instance
        .collection("Posts")
        .doc(widget.array[widget.index]['postId'])
        .collection("Comments")
        .add({
      'Name': UserDetails.name,
      'createdAt': Timestamp.now(),
      'CommentedBy': UserDetails.uid,
      'Username': UserDetails.username,
      'Comment': comment.text,
      'ProfilePhotoUrl': UserDetails.profilePhotoUrl,
    }).then(
      (value) async {
        var documentId = value.id;
        FirebaseFirestore.instance
            .collection('Posts')
            .doc(widget.array[widget.index]['postId'])
            .collection("Comments")
            .doc(documentId)
            .update({
          'commentId': documentId,
        });
        final QuerySnapshot qSnap = await FirebaseFirestore.instance
            .collection('Posts')
            .doc(widget.array[widget.index]['postId'])
            .collection("Comments")
            .get();
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(
        //       "Commented to ${widget.array[widget.index]['Username']}",
        //       style: TextStyle(fontSize: 16),
        //     ),
        //   ),
        // );
        setState(() {
          numberOfComments = qSnap.docs.length;
          showSpinner = false;
          comment.clear();
        });
      },
    );
  }

  //Post Like Row
  int liked_button = 0;
  bool isMount = true;
  String date = "", time = "";

  // Liking a Post
  likePost(int likeId) async {
    await FirebaseFirestore.instance
        .collection("Posts")
        .doc(widget.array[widget.index]['postId'])
        .collection("Likes")
        .doc(UserDetails.uid)
        .set({
      "LikeType": likeId,
      "LikedBy": UserDetails.uid,
    }).then(
      (value) async {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(
        //       "Reacted to ${widget.array[widget.index]['Username']}",
        //       style: TextStyle(fontSize: 16),
        //     ),
        //   ),
        // );
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('Posts')
            .doc(widget.array[widget.index]['postId'])
            .collection("Likes")
            .get();
        likes[0] = 0;
        likes[1] = 0;
        likes[2] = 0;
        likes[3] = 0;
        likes[4] = 0;
        likes[5] = 0;
        likes[6] = 0;
        likes[7] = 0;
        likes[8] = 0;
        likes[9] = 0;
        likes[10] = 0;
        List<dynamic> result = snapshot.docs.map((doc) => doc.data()).toList();
        for (int i = 0; i < result.length; i++) {
          if (likes[result[i]['LikeType']] != null) {
            likes[result[i]['LikeType']] =
                likes[result[i]['LikeType']]!.toInt() + 1;
          }
        }
        if (isMount) {
          setState(() {
            liked_button = likeId;
          });
        }
      },
    );
  }

  var likes = <int, int>{
    0: 0,
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0,
    8: 0,
    9: 0,
    10: 0
  };

  Future getInitData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Posts')
        .doc(widget.array[widget.index]['postId'])
        .collection("Likes")
        .get();

    List<dynamic> result = snapshot.docs.map((doc) => doc.data()).toList();
    for (int i = 0; i < result.length; i++) {
      if (likes[result[i]['LikeType']] != null) {
        if (result[i]['LikedBy'] == UserDetails.uid) {
          liked_button = result[i]['LikeType'];
        }
        likes[result[i]['LikeType']] =
            likes[result[i]['LikeType']]!.toInt() + 1;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    numberOfComments = widget.nComments;
    getInitData().then((value) {
      setState(() {});
    });
    DateTime myDateTime = widget.array[widget.index]['createdAt'].toDate();
    DateTime currentDateTime = Timestamp.now().toDate();
    String formattedDateTime =
        DateFormat('dd-MM-yyyy – hh:mm a').format(myDateTime);
    String formattedDateTimecurr =
        DateFormat('dd-MM-yyyy – hh:mm a').format(currentDateTime);
    String s1 = formattedDateTime.substring(0, 10);
    String s2 = formattedDateTimecurr.substring(0, 10);

    String formatDate = DateFormat.yMMMEd().format(myDateTime);
    // print(formatDate);
    if (s1 == s2) {
      date = "";
      time = formattedDateTime.substring(13);
    } else {
      date = formatDate.substring(4, 11);
      time = formattedDateTime.substring(13);
    }
    // print(formattedDateTime);
  }

  deleteComment(String curr_doc) async {
    // print("Delete Comment button pressed");
    setState(() {
      showSpinner = true;
    });
    Navigator.pop(context);

    // Deleting the Comment Document
    await FirebaseFirestore.instance
        .collection("Posts")
        .doc(widget.array[widget.index]['postId'])
        .collection("Comments")
        .doc(curr_doc)
        .delete();
    setState(() {
      showSpinner = false;
    });
  }

  void handleClick(int item, String curr_doc) async {
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
                      "Are you Sure you want to delete this Comment ?",
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
                              await deleteComment(curr_doc);
                              setState(() {
                                numberOfComments -= 1;
                              });
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
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              width: deviceWidth,
              height: deviceHeight,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                      ],
                    ),
                    SizedBox(height: 30),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(100, 94, 94, 1),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          '${widget.array[widget.index]['ProfilePhotoUrl']}'),
                                      fit: BoxFit.fitWidth),
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(36, 36)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: deviceWidth - 78,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.array[widget.index]['Name']}",
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
                                  "@${widget.array[widget.index]['Username']}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(
                                          0, 0, 0, 0.8100000023841858),
                                      fontFamily: 'Lato',
                                      fontSize: 15,
                                      letterSpacing:
                                          0 /*percentages not used in flutter. defaulting to zero*/,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "${widget.array[widget.index]['Message']}",
                                  textAlign: TextAlign.left,
                                  maxLines: 5,
                                  style: TextStyle(
                                      color: Color.fromRGBO(
                                          0, 0, 0, 0.949999988079071),
                                      fontFamily: 'Lato',
                                      fontSize: 15,
                                      letterSpacing:
                                          0 /*percentages not used in flutter. defaulting to zero*/,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: deviceWidth * 0.8,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          likePost(1);
                                        },
                                        child: Column(
                                          children: [
                                            ImageIcon(
                                              AssetImage(
                                                  "assets/images/Image -11.png"),
                                              color: Colors.pink,
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "${likes[1]}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: liked_button == 1
                                                      ? pink
                                                      : Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                  fontFamily: 'Lato',
                                                  fontSize: 14,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: liked_button == 1
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  height: 1),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          likePost(2);
                                        },
                                        child: Column(
                                          children: [
                                            ImageIcon(
                                              AssetImage(
                                                  "assets/images/Image -12.png"),
                                              color: Colors.pink,
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "${likes[2]}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: liked_button == 2
                                                      ? pink
                                                      : Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                  fontFamily: 'Lato',
                                                  fontSize: 14,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: liked_button == 2
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  height: 1),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          likePost(3);
                                        },
                                        child: Column(
                                          children: [
                                            ImageIcon(
                                              AssetImage(
                                                  "assets/images/Image -13.png"),
                                              color: Colors.pink,
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "${likes[3]}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: liked_button == 3
                                                      ? pink
                                                      : Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                  fontFamily: 'Lato',
                                                  fontSize: 14,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: liked_button == 3
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  height: 1),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          likePost(4);
                                        },
                                        child: Column(
                                          children: [
                                            ImageIcon(
                                              AssetImage(
                                                  "assets/images/Image -14.png"),
                                              color: Colors.red,
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "${likes[4]}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: liked_button == 4
                                                      ? pink
                                                      : Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                  fontFamily: 'Lato',
                                                  fontSize: 14,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: liked_button == 4
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  height: 1),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          likePost(5);
                                        },
                                        child: Column(
                                          children: [
                                            ImageIcon(
                                              AssetImage(
                                                  "assets/images/Image -8.png"),
                                              color: Colors.blue,
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "${likes[5]}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: liked_button == 5
                                                      ? pink
                                                      : Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                  fontFamily: 'Lato',
                                                  fontSize: 14,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: liked_button == 5
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  height: 1),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          likePost(6);
                                        },
                                        child: Column(
                                          children: [
                                            ImageIcon(
                                              AssetImage(
                                                  "assets/images/Image -16.png"),
                                              color: Colors.red,
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "${likes[6]}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: liked_button == 6
                                                      ? pink
                                                      : Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                  fontFamily: 'Lato',
                                                  fontSize: 14,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: liked_button == 6
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  height: 1),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          likePost(7);
                                        },
                                        child: Column(
                                          children: [
                                            ImageIcon(
                                              AssetImage(
                                                  "assets/images/Recommend-1.png"),
                                              color: Colors.greenAccent,
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "${likes[7]}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: liked_button == 7
                                                      ? pink
                                                      : Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                  fontFamily: 'Lato',
                                                  fontSize: 14,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: liked_button == 7
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  height: 1),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         IndividualPost(
                                          //       array: widget.array,
                                          //       index: widget.index,
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: Column(
                                          children: [
                                            ImageIcon(
                                              AssetImage(
                                                  "assets/images/Image -10.png"),
                                              color: Colors.greenAccent,
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "${max(numberOfComments, 0)}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                  fontFamily: 'Lato',
                                                  fontSize: 14,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          likePost(9);
                                        },
                                        child: Column(
                                          children: [
                                            ImageIcon(
                                              AssetImage(
                                                  "assets/images/wow-1.png"),
                                              color: Colors.yellow,
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "${likes[9]}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: liked_button == 9
                                                      ? pink
                                                      : Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                  fontFamily: 'Lato',
                                                  fontSize: 14,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: liked_button == 9
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  height: 1),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          likePost(10);
                                        },
                                        child: Column(
                                          children: [
                                            ImageIcon(
                                              AssetImage(
                                                  "assets/images/Image -18.png"),
                                              color: Colors.black,
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "${likes[10]}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: liked_button == 10
                                                      ? pink
                                                      : Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                  fontFamily: 'Lato',
                                                  fontSize: 14,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: liked_button == 10
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  height: 1),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: deviceWidth * .7,
                                child: TextField(
                                  controller: comment,
                                  textAlign: TextAlign.left,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: "Type your comment...",
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
                              if (comment.text == null ||
                                  comment.text.length == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Please Write a Comment",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                );
                              } else {
                                setState(() {});
                                addComment();
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
                                  'Comment',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
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
                    SizedBox(height: 20),
                    Text(
                      "Comments",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Lato',
                          fontSize: 17,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.bold,
                          height: 1),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Column(
                        children: [
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Posts')
                                  .doc(widget.array[widget.index]['postId'])
                                  .collection("Comments")
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
                                list = notificationsSnapshots.data!.docs;
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          // onTap: () async {
                                          //   List array = [];
                                          //   var _doc1 = await FirebaseFirestore
                                          //       .instance
                                          //       .collection("Users")
                                          //       .doc(list[index]['CommentedBy'])
                                          //       .get();
                                          //   bool docStatus1 = _doc1.exists;
                                          //   if (docStatus1 == true) {
                                          //     array.add(_doc1);
                                          //     if (list[index]['CommentedBy'] ==
                                          //         UserDetails.uid) {
                                          //     } else {
                                          //       Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               ProfilePage(
                                          //             array: array,
                                          //             index: 0,
                                          //           ),
                                          //         ),
                                          //       );
                                          //     }
                                          //   }
                                          // },
                                          child: Stack(
                                            children: [
                                              CommentModelz(
                                                array: list,
                                                index: index,
                                              ),
                                              UserDetails.uid ==
                                                      list[index]['CommentedBy']
                                                  ? Positioned(
                                                      top: 5,
                                                      right: 10,
                                                      child: PopupMenuButton(
                                                        onSelected: (item) =>
                                                            handleClick(
                                                                0,
                                                                list[index][
                                                                    'commentId']),
                                                        itemBuilder:
                                                            (context) => [
                                                          PopupMenuItem<int>(
                                                              value: 0,
                                                              child: Text(
                                                                  'Delete')),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                        if (index == list.length - 1)
                                          SizedBox(height: 80),
                                      ],
                                    );
                                  },
                                );
                              }),
                        ],
                      ),
                    ),
                    // COmments
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
