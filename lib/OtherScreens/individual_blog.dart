import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_media/DashBoard%20Screens/home.dart';
import 'package:social_media/Nav%20Drawer%20Screens/blog.dart';
import 'package:social_media/OtherScreens/profile_page.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/model/comment_mdel.dart';
import 'package:social_media/model/post_model.dart';

import '../constants.dart';

class IndividualBlog extends StatefulWidget {
  const IndividualBlog({Key? key, this.array, this.index, this.nComments})
      : super(key: key);

  final array, index, nComments;

  @override
  _IndividualBlogState createState() => _IndividualBlogState();
}

class _IndividualBlogState extends State<IndividualBlog> {
  var list = [];
  TextEditingController comment = TextEditingController();
  bool showSpinner = false;
  int numberOfComments = 0;

  addComment() async {
    setState(() {
      showSpinner = true;
    });
    await FirebaseFirestore.instance
        .collection("Blogs")
        .doc(widget.array[widget.index]['blogId'])
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
            .collection('Blogs')
            .doc(widget.array[widget.index]['blogId'])
            .collection("Comments")
            .doc(documentId)
            .update({
          'commentId': documentId,
        });
        final QuerySnapshot qSnap = await FirebaseFirestore.instance
            .collection('Blogs')
            .doc(widget.array[widget.index]['blogId'])
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

  var likes = <int, int>{
    0: 0,
    1: 0,
  };

  // Liking a Blog
  likeBlog(int id) async {
    await FirebaseFirestore.instance
        .collection("Blogs")
        .doc(widget.array[widget.index]['blogId'])
        .collection("Likes")
        .doc(UserDetails.uid)
        .set({
      "LikeType": id,
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
            .collection('Blogs')
            .doc(widget.array[widget.index]['blogId'])
            .collection("Likes")
            .get();
        likes[0] = 0;
        likes[1] = 0;
        List<dynamic> result = snapshot.docs.map((doc) => doc.data()).toList();
        for (int i = 0; i < result.length; i++) {
          if (likes[result[i]['LikeType']] != null) {
            likes[result[i]['LikeType']] =
                likes[result[i]['LikeType']]!.toInt() + 1;
          }
        }
        if (isMount) {
          setState(() {
            liked_button = id;
          });
        }
      },
    );
  }

  Future getInitData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Blogs')
        .doc(widget.array[widget.index]['blogId'])
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
        .collection("Blogs")
        .doc(widget.array[widget.index]['blogId'])
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

  // Tag User Function (redirect to UserPage)
  Future getUserFromUsername(String word) async {
    word = word.substring(1);
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('Users').get();

    final _snap = snap.docs;
    // print(word);
    for (int i = 0; i < _snap.length; i++) {
      // bc khupch vel lagla
      // print(_snap[i]['Info']['Uid']);
      // print(_snap[i]['Info']['Username']);
      if (_snap[i]['Info']['Username'] == word) {
        /// Write your method here
        print(_snap[i]['Info']['Uid']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              array: _snap,
              index: i,
            ),
          ),
        );
      }
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
                builder: (context) => Blogs(),
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
                                  builder: (context) => Blogs(),
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
                      width: deviceWidth,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () async {
                                  List array = [];
                                  var _doc1 = await FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(
                                          widget.array[widget.index]['AddedBy'])
                                      .get();
                                  bool docStatus1 = _doc1.exists;
                                  if (docStatus1 == true) {
                                    array.add(_doc1);
                                    if (array[0]['Info']['Uid'] ==
                                        UserDetails.uid) {
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfilePage(
                                            array: array,
                                            index: 0,
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Container(
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
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
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
                                style: const TextStyle(
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
                                "${date} ${time}",
                                textAlign: TextAlign.left,
                                maxLines: 5,
                                style: TextStyle(
                                    color: Color.fromRGBO(
                                        0, 0, 0, 0.949999988079071),
                                    fontFamily: 'Lato',
                                    fontSize: 12,
                                    letterSpacing:
                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: deviceWidth * .81,
                                child: RichText(
                                  text: TextSpan(
                                      children: widget.array[widget.index]
                                              ['Message']
                                          .split(" ")
                                          .map<InlineSpan>(
                                    //ithe pn khup vel lagla (40min) inlinespan error
                                    (word) {
                                      // print(word);
                                      if (word.startsWith('@')) {
                                        return TextSpan(
                                            text: '$word ',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 17.0),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                getUserFromUsername(word)
                                                    .then((value) {});
                                              });
                                      }
                                      return TextSpan(
                                          text: '$word ',
                                          style: const TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.black));
                                    },
                                  ).toList()),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: deviceWidth * 0.75,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        print("Liked Button : ${liked_button}");
                                        if (liked_button == 1) {
                                          likeBlog(0);
                                        } else {
                                          likeBlog(1);
                                        }
                                      },
                                      child: Container(
                                        width: 92,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(9),
                                            topRight: Radius.circular(9),
                                            bottomLeft: Radius.circular(9),
                                            bottomRight: Radius.circular(9),
                                          ),
                                          color:
                                              Color.fromRGBO(243, 243, 243, 1),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.thumb_up_alt_rounded,
                                              color: liked_button == 1
                                                  ? pink
                                                  : Color.fromRGBO(0, 0, 0, 1),
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              "${likes[1]}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: liked_button == 1
                                                      ? pink
                                                      : Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                  fontFamily: 'Lato',
                                                  fontSize: 16,
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
                                    ),
                                    Container(
                                      width: 92,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(9),
                                          topRight: Radius.circular(9),
                                          bottomLeft: Radius.circular(9),
                                          bottomRight: Radius.circular(9),
                                        ),
                                        color: Color.fromRGBO(243, 243, 243, 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.comment),
                                          SizedBox(width: 3),
                                          Text(
                                            "${numberOfComments}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                                fontFamily: 'Lato',
                                                fontSize: 16,
                                                letterSpacing:
                                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                                fontWeight: FontWeight.normal,
                                                height: 1),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 92,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(9),
                                          topRight: Radius.circular(9),
                                          bottomLeft: Radius.circular(9),
                                          bottomRight: Radius.circular(9),
                                        ),
                                        color: Color.fromRGBO(243, 243, 243, 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.share),
                                          // SizedBox(width: 3),
                                          // Text(
                                          //   '16k',
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //       color: Color.fromRGBO(0, 0, 0, 1),
                                          //       fontFamily: 'Lato',
                                          //       fontSize: 16,
                                          //       letterSpacing:
                                          //           0 /*percentages not used in flutter. defaulting to zero*/,
                                          //       fontWeight: FontWeight.normal,
                                          //       height: 1),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
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
                                  .collection('Blogs')
                                  .doc(widget.array[widget.index]['blogId'])
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
