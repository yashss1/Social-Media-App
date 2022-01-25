import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_media/OtherScreens/individual_post.dart';
import 'package:social_media/OtherScreens/profile_page.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/constants.dart';

class PostModel extends StatefulWidget {
  const PostModel({Key? key, this.array, this.index}) : super(key: key);

  final array, index;

  @override
  State<PostModel> createState() => _PostModelState();
}

class _PostModelState extends State<PostModel> {
  bool showSpinner = false;
  int liked_button = 0;
  int numberOfComments = 0;
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
    getInitData().then((value) async {
      final QuerySnapshot qSnap = await FirebaseFirestore.instance
          .collection('Posts')
          .doc(widget.array[widget.index]['postId'])
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IndividualPost(
                    array: widget.array,
                    index: widget.index,
                  ),
                ),
              );
            },
            child: Container(
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
                  Text(
                    "${widget.array[widget.index]['Message']}",
                    textAlign: TextAlign.left,
                    maxLines: 5,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.949999988079071),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            if (liked_button == 1) {
                              likePost(0);
                            } else {
                              likePost(1);
                            }
                          },
                          child: Column(
                            children: [
                              ImageIcon(
                                AssetImage("assets/images/Image -11.png"),
                                color: Colors.pink,
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${likes[1]}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: liked_button == 1
                                        ? pink
                                        : Color.fromRGBO(0, 0, 0, 1),
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
                            if (liked_button == 2) {
                              likePost(0);
                            } else {
                              likePost(2);
                            }
                          },
                          child: Column(
                            children: [
                              ImageIcon(
                                AssetImage("assets/images/Image -12.png"),
                                color: Colors.pink,
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${likes[2]}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: liked_button == 2
                                        ? pink
                                        : Color.fromRGBO(0, 0, 0, 1),
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
                            if (liked_button == 3) {
                              likePost(0);
                            } else {
                              likePost(3);
                            }
                          },
                          child: Column(
                            children: [
                              ImageIcon(
                                AssetImage("assets/images/Image -13.png"),
                                color: Colors.pink,
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${likes[3]}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: liked_button == 3
                                        ? pink
                                        : Color.fromRGBO(0, 0, 0, 1),
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
                            if (liked_button == 4) {
                              likePost(0);
                            } else {
                              likePost(4);
                            }
                          },
                          child: Column(
                            children: [
                              ImageIcon(
                                AssetImage("assets/images/Image -14.png"),
                                color: Colors.red,
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${likes[4]}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: liked_button == 4
                                        ? pink
                                        : Color.fromRGBO(0, 0, 0, 1),
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
                            if (liked_button == 5) {
                              likePost(0);
                            } else {
                              likePost(5);
                            }
                          },
                          child: Column(
                            children: [
                              ImageIcon(
                                AssetImage("assets/images/Image -8.png"),
                                color: Colors.blue,
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${likes[5]}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: liked_button == 5
                                        ? pink
                                        : Color.fromRGBO(0, 0, 0, 1),
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
                            if (liked_button == 6) {
                              likePost(0);
                            } else {
                              likePost(6);
                            }
                          },
                          child: Column(
                            children: [
                              ImageIcon(
                                AssetImage("assets/images/Image -16.png"),
                                color: Colors.red,
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${likes[6]}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: liked_button == 6
                                        ? pink
                                        : Color.fromRGBO(0, 0, 0, 1),
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
                            if (liked_button == 7) {
                              likePost(0);
                            } else {
                              likePost(7);
                            }
                          },
                          child: Column(
                            children: [
                              ImageIcon(
                                AssetImage("assets/images/Recommend-1.png"),
                                color: Colors.greenAccent,
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${likes[7]}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: liked_button == 7
                                        ? pink
                                        : Color.fromRGBO(0, 0, 0, 1),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IndividualPost(
                                  array: widget.array,
                                  index: widget.index,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              ImageIcon(
                                AssetImage("assets/images/Image -10.png"),
                                color: Colors.greenAccent,
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${numberOfComments}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
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
                            if (liked_button == 9) {
                              likePost(0);
                            } else {
                              likePost(9);
                            }
                          },
                          child: Column(
                            children: [
                              ImageIcon(
                                AssetImage("assets/images/wow-1.png"),
                                color: Colors.yellow,
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${likes[9]}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: liked_button == 9
                                        ? pink
                                        : Color.fromRGBO(0, 0, 0, 1),
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
                            if (liked_button == 10) {
                              likePost(0);
                            } else {
                              likePost(10);
                            }
                          },
                          child: Column(
                            children: [
                              ImageIcon(
                                AssetImage("assets/images/Image -18.png"),
                                color: Colors.black,
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${likes[10]}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: liked_button == 10
                                        ? pink
                                        : Color.fromRGBO(0, 0, 0, 1),
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
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
