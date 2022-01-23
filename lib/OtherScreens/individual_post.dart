import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/model/comment_mdel.dart';
import 'package:social_media/model/post_model.dart';

class IndividualPost extends StatefulWidget {
  const IndividualPost({Key? key, this.array, this.index}) : super(key: key);

  final array, index;

  @override
  _IndividualPostState createState() => _IndividualPostState();
}

class _IndividualPostState extends State<IndividualPost> {
  TextEditingController comment = TextEditingController();
  bool showSpinner = false;

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
        FirebaseFirestore.instance.collection('Posts').doc(documentId).update({
          'commentId': documentId,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Commented to ${widget.array[widget.index]['Username']}",
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
        setState(() {
          showSpinner = false;
          comment.clear();
        });
      },
    );
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
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            width: deviceWidth,
            height: deviceHeight,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                borderRadius:
                                    BorderRadius.all(Radius.elliptical(36, 36)),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 50, top: 15, bottom: 15),
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(100, 94, 94, 1),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          "${UserDetails.profilePhotoUrl}"),
                                      fit: BoxFit.fitWidth),
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(52, 52)),
                                )),
                            Container(
                              width: deviceWidth * .55,
                              child: TextField(
                                controller: comment,
                                textAlign: TextAlign.left,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: "Add a Comment",
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
                              final list = notificationsSnapshots.data!.docs;
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      CommentModelz(
                                        array: list,
                                        index: index,
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
    );
  }
}
