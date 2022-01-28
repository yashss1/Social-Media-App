import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_media/OtherScreens/individual_blog.dart';
import 'package:social_media/OtherScreens/profile_page.dart';
import 'package:social_media/Services/user_details.dart';

import '../constants.dart';

class BlogComment extends StatefulWidget {
  const BlogComment({
    Key? key,
    this.array,
    this.index,
  }) : super(key: key);

  final array, index;

  @override
  State<BlogComment> createState() => _BlogCommentState();
}

class _BlogCommentState extends State<BlogComment> {
  bool showSpinner = false;
  int liked_button = 0;
  int numberOfComments = 0;
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
  void initState() {
    super.initState();
    getInitData().then((value) async {
      final QuerySnapshot qSnap = await FirebaseFirestore.instance
          .collection('Blogs')
          .doc(widget.array[widget.index]['blogId'])
          .collection("Comments")
          .get();
      final int documents = qSnap.docs.length;

      setState(() {
        numberOfComments = documents;
      });
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

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
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
                      .doc(widget.array[widget.index]['AddedBy'])
                      .get();
                  bool docStatus1 = _doc1.exists;
                  if (docStatus1 == true) {
                    array.add(_doc1);
                    if (array[0]['Info']['Uid'] == UserDetails.uid) {
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
                    borderRadius: BorderRadius.all(Radius.elliptical(36, 36)),
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
                    color: Color.fromRGBO(0, 0, 0, 0.8100000023841858),
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
                    color: Color.fromRGBO(0, 0, 0, 0.949999988079071),
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
                      children: widget.array[widget.index]['Message']
                          .split(" ")
                          .map<InlineSpan>(
                    //ithe pn khup vel lagla (40min) inlinespan error
                    (word) {
                      // print(word);
                      if (word.startsWith('@')) {
                        return TextSpan(
                            text: '$word ',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 17.0),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                getUserFromUsername(word).then((value) {});
                              });
                      }
                      return TextSpan(
                          text: '$word ',
                          style: const TextStyle(
                              fontSize: 17.0, color: Colors.black));
                    },
                  ).toList()),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: deviceWidth * 0.75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          color: Color.fromRGBO(243, 243, 243, 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                      : Color.fromRGBO(0, 0, 0, 1),
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
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IndividualBlog(
                                array: widget.array,
                                index: widget.index,
                                nComments: numberOfComments,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.comment),
                            SizedBox(width: 3),
                            Text(
                              "${numberOfComments}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
