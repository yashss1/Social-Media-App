import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_full_image_screen/custom_full_image_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_media/Nav%20Drawer%20Screens/music.dart';
import 'package:social_media/Services/notification_helper.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/model/friends_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, this.array, this.index}) : super(key: key);

  final array, index;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showSpinner = true;
  bool noFollowers = false;
  String followStatus = "Follow";
  var arrayFriend, arr;

  Future followUser() async {
    setState(() {
      showSpinner = true;
    });

    // Adding this UID in my Following Collection
    var _doc = await FirebaseFirestore.instance
        .collection("Following")
        .doc(UserDetails.uid)
        .get();
    bool docStatus = _doc.exists;

    if (docStatus == false) {
      await NotificationHelper()
          .getTokenForFollowing(widget.array[widget.index]['Info']['Uid']);
      FirebaseFirestore.instance
          .collection('Following')
          .doc(UserDetails.uid)
          .set({
        'Following': FieldValue.arrayUnion([
          {
            'UID': widget.array[widget.index]['Info']['Uid'],
          }
        ])
      }).then((value) async {
        setState(() {
          showSpinner = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "You have started following ${widget.array[widget.index]['Info']['Name']}",
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
        setState(() {
          followStatus = "Following";
        });
      });
    } else {
      FirebaseFirestore.instance
          .collection('Following')
          .doc(UserDetails.uid)
          .update({
        'Following': FieldValue.arrayUnion([
          {
            'UID': widget.array[widget.index]['Info']['Uid'],
          }
        ])
      }).then((value) async {
        setState(() {
          showSpinner = false;
        });

        await NotificationHelper()
            .getTokenForFollowing(widget.array[widget.index]['Info']['Uid']);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "You have started following ${widget.array[widget.index]['Info']['Name']}",
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
        setState(() {
          followStatus = "Following";
        });
      });
    }

    // Adding my UID in this UID's Follower Collection
    var _doc1 = await FirebaseFirestore.instance
        .collection("Followers")
        .doc(widget.array[widget.index]['Info']['Uid'])
        .get();
    bool docStatus1 = _doc1.exists;

    if (docStatus1 == false) {
      FirebaseFirestore.instance
          .collection('Followers')
          .doc(widget.array[widget.index]['Info']['Uid'])
          .set({
        'Followers': FieldValue.arrayUnion([
          {
            'UID': UserDetails.uid,
          }
        ])
      }).then((value) async {
        // Followers Retrieval
        var _doc1 = await FirebaseFirestore.instance
            .collection("Followers")
            .doc(widget.array[widget.index]['Info']['Uid'])
            .get();
        bool docStatus1 = _doc1.exists;
        if (docStatus1 == false) {
          setState(() {
            noFollowers = true;
          });
        } else {
          setState(() {
            followers = _doc1['Followers'];
            print(followers);
          });
        }
        setState(() {
          showSpinner = false;
        });
      });
    } else {
      FirebaseFirestore.instance
          .collection('Followers')
          .doc(widget.array[widget.index]['Info']['Uid'])
          .update({
        'Followers': FieldValue.arrayUnion([
          {
            'UID': UserDetails.uid,
          }
        ])
      }).then((value) async {
        // Followers Retrieval
        var _doc1 = await FirebaseFirestore.instance
            .collection("Followers")
            .doc(widget.array[widget.index]['Info']['Uid'])
            .get();
        bool docStatus1 = _doc1.exists;
        if (docStatus1 == false) {
          setState(() {
            noFollowers = true;
          });
        } else {
          setState(() {
            followers = _doc1['Followers'];
            print(followers);
          });
        }
        setState(() {
          showSpinner = false;
        });
      });
    }
  }

  Future unFollowUser() async {
    setState(() {
      showSpinner = true;
    });

    // Removing this UID from my Following Collection
    // Extracting the Array of Friends
    var arrayf1, arrayNew1 = <Map>[];
    var _doc = await FirebaseFirestore.instance
        .collection("Following")
        .doc(UserDetails.uid)
        .get();
    bool docStatus = _doc.exists;
    if (docStatus == false) {
    } else {
      arrayf1 = _doc['Following'];
    }
    for (var i = 0; i < arrayf1.length; i++) {
      if (arrayf1[i]['UID'] == widget.array[widget.index]['Info']['Uid']) {
      } else {
        if (arrayNew1 == null) {
          arrayNew1 = arrayf1[i];
        } else {
          arrayNew1.add(arrayf1[i]);
        }
      }
    }

    // Deleting the Document
    FirebaseFirestore.instance
        .collection('Following')
        .doc(UserDetails.uid)
        .delete();
    // Adding the Document again
    FirebaseFirestore.instance
        .collection('Following')
        .doc(UserDetails.uid)
        .set({
      'Following': arrayNew1,
    }).then((value) {
      setState(() {
        showSpinner = false;
        followStatus = "Follow";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Unfollowed ${widget.array[widget.index]['Info']['Name']}",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    });

    // Deleting my UID in this UID's Follower Collection
    // Extracting the Array of Friends
    var arrayf2, arrayNew2 = <Map>[];
    var _doc1 = await FirebaseFirestore.instance
        .collection("Followers")
        .doc(widget.array[widget.index]['Info']['Uid'])
        .get();
    bool docStatus1 = _doc1.exists;
    if (docStatus1 == false) {
    } else {
      arrayf2 = _doc1['Followers'];
    }
    for (var i = 0; i < arrayf2.length; i++) {
      if (arrayf2[i]['UID'] == UserDetails.uid) {
      } else {
        if (arrayNew2 == null) {
          arrayNew2 = arrayf2[i];
        } else {
          arrayNew2.add(arrayf2[i]);
        }
      }
    }

    setState(() {
      showSpinner = true;
    });
    // Deleting the Document
    FirebaseFirestore.instance
        .collection('Followers')
        .doc(widget.array[widget.index]['Info']['Uid'])
        .delete();
    // Adding the Document again
    FirebaseFirestore.instance
        .collection('Followers')
        .doc(widget.array[widget.index]['Info']['Uid'])
        .set({
      'Followers': arrayNew2,
    }).then((value) async {
      // Followers Retrieval
      var _doc1 = await FirebaseFirestore.instance
          .collection("Followers")
          .doc(widget.array[widget.index]['Info']['Uid'])
          .get();
      bool docStatus1 = _doc1.exists;
      if (docStatus1 == false) {
        setState(() {
          noFollowers = true;
        });
      } else {
        setState(() {
          followers = _doc1['Followers'];
          print(followers);
        });
      }
      setState(() {
        showSpinner = false;
      });
    });
  }

  Future checkFriend() async {
    var _doc = await FirebaseFirestore.instance
        .collection("Following")
        .doc(UserDetails.uid)
        .get();
    bool docStatus = _doc.exists;

    if (docStatus == false) {
      setState(() {
        followStatus = "Follow";
      });
    } else {
      arr = _doc['Following'];
      if (arrayFriend == null) {
        arrayFriend = arr;
      } else {
        arrayFriend += arr;
      }
      // print(arrayFriend);
      for (var i = 0; i < arrayFriend.length; i++) {
        if (arrayFriend[i]['UID'] ==
            widget.array[widget.index]['Info']['Uid']) {
          // print("Got it");
          setState(() {
            followStatus = "Following";
          });
        }
      }
    }
  }

  var followers, following, frndList = [];
  bool noFollowing = false;

  Future getData() async {
    // Following Retrieval
    var _doc = await FirebaseFirestore.instance
        .collection("Following")
        .doc(widget.array[widget.index]['Info']['Uid'])
        .get();
    bool docStatus = _doc.exists;
    if (docStatus == false) {
      setState(() {
        noFollowing = true;
      });
    } else {
      if (_doc['Following'].length == 0) {
        setState(() {
          noFollowing = true;
        });
      } else {
        setState(() {
          following = _doc['Following'];
        });
      }
    }

    // Followers Retrieval
    var _doc1 = await FirebaseFirestore.instance
        .collection("Followers")
        .doc(widget.array[widget.index]['Info']['Uid'])
        .get();
    bool docStatus1 = _doc1.exists;
    if (docStatus1 == false) {
      setState(() {
        noFollowers = true;
      });
    } else {
      setState(() {
        followers = _doc1['Followers'];
        print(followers);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Checking whether this UID is already my friend
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      checkFriend().then((value) async {
        setState(() {
          showSpinner = false;
        });
        await getData().then((value) async {
          for (int i = 0; i < following.length; i++) {
            var curr_doc = await FirebaseFirestore.instance
                .collection("Users")
                .doc(following[i]['UID'])
                .get();

            Map<String, dynamic> mp = {
              "Info": {
                'Name': curr_doc['Info']['Name'],
                'Username': curr_doc['Info']['Username'],
                'Email': curr_doc['Info']['Email'],
                'Uid': curr_doc['Info']['Uid'],
                'BgPhotoUrl': curr_doc['Info']['BgPhotoUrl'],
                'ProfilePhotoUrl': curr_doc['Info']['ProfilePhotoUrl'],
                'TagLine': curr_doc['Info']['TagLine'],
                'Profession': curr_doc['Info']['Profession'],
                'Location': curr_doc['Info']['Location'],
                'DOB': curr_doc['Info']['DOB'],
                'PhoneNumber': curr_doc['Info']['PhoneNumber'],
              }
            };
            frndList.add(mp);
          }
          // print(frndList);
          setState(() {});
        });
      });
    });
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
            width: deviceWidth,
            height: deviceHeight,
            child: Column(
              children: [
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: deviceHeight * 0.30,
                          width: deviceWidth,
                          child: Stack(
                            children: [
                              ImageCachedFullscreen(
                                imageUrl:
                                    "${widget.array[widget.index]['Info']['BgPhotoUrl']}",
                                imageWidth: deviceWidth,
                                imageHeight: deviceHeight * 0.25,
                                imageFit: BoxFit.fitWidth,
                                imageDetailsHeight: 450,
                                imageDetailsWidth: 400,
                                withHeroAnimation: true,
                                placeholder: Container(
                                  child: Icon(Icons.check),
                                ),
                                errorWidget: Container(
                                  child: Icon(Icons.error),
                                ),
                                placeholderDetails: Container(),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ImageCachedFullscreen(
                                  imageUrl:
                                      "${widget.array[widget.index]['Info']['ProfilePhotoUrl']}",
                                  imageWidth: 125,
                                  imageHeight: 122,
                                  imageBorderRadius: 125,
                                  imageFit: BoxFit.cover,
                                  imageDetailsHeight: 450,
                                  imageDetailsWidth: 450,
                                  withHeroAnimation: true,
                                  placeholder: Container(
                                    child: Icon(Icons.check),
                                  ),
                                  errorWidget: Container(
                                    child: Icon(Icons.error),
                                  ),
                                  placeholderDetails: Container(),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                left: 20,
                                child: InkWell(
                                  splashColor: Colors.pink,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    size: 28,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          "${widget.array[widget.index]['Info']['Name']}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Lato',
                              fontSize: 20,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.bold,
                              height: 1),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "${widget.array[widget.index]['Info']['TagLine']}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Lato',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () async {
                            if (followStatus == 'Follow') {
                              await followUser();
                            } else {
                              await unFollowUser();
                            }
                          },
                          child: Container(
                            width: 151,
                            height: 46,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: pink,
                                width: 1,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${followStatus}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    letterSpacing:
                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 35),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Work at :',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            letterSpacing:
                                                0 /*percentages not used in flutter. defaulting to zero*/,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "${widget.array[widget.index]['Info']['Profession']}",
                                        textAlign: TextAlign.left,
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
                                  Row(
                                    children: [
                                      Text(
                                        'Birthday :',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            letterSpacing:
                                                0 /*percentages not used in flutter. defaulting to zero*/,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "${widget.array[widget.index]['Info']['DOB']}",
                                        textAlign: TextAlign.left,
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
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Followed By :',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            letterSpacing:
                                                0 /*percentages not used in flutter. defaulting to zero*/,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        followers == null
                                            ? "0 People"
                                            : '${followers.length} People',
                                        textAlign: TextAlign.left,
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
                                  Row(
                                    children: [
                                      Text(
                                        'Live in :',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            letterSpacing:
                                                0 /*percentages not used in flutter. defaulting to zero*/,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "${widget.array[widget.index]['Info']['Location']}",
                                        textAlign: TextAlign.left,
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
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 45),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Following',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontFamily: 'Lato',
                                        fontSize: 16,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.bold,
                                        height: 1),
                                  ),
                                  Text(
                                    'See All',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(
                                            0, 0, 0, 0.41999998688697815),
                                        fontFamily: 'Lato',
                                        fontSize: 14,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Text(
                                following == null
                                    ? "0 Following"
                                    : '${following.length} Following',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(
                                        0, 0, 0, 0.6299999952316284),
                                    fontFamily: 'Lato',
                                    fontSize: 14,
                                    letterSpacing:
                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  Container(
                                    height: 120,
                                    width: deviceWidth - 32,
                                    child: (frndList == null ||
                                            frndList.length == 0)
                                        ? noFollowing == true
                                            ? Container()
                                            : Center(
                                                child: SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 3.0,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Colors.pink,
                                                    ),
                                                  ),
                                                ),
                                              )
                                        : ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: frndList == null
                                                ? 0
                                                : frndList.length <= 10
                                                    ? frndList.length
                                                    : 10,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             ProfilePage(
                                                  //               array: frndList,
                                                  //               index: index,
                                                  //             )));
                                                },
                                                child: FriendModel(
                                                    name: frndList[index]
                                                        ['Info']['Name'],
                                                    img: frndList[index]['Info']
                                                        ['ProfilePhotoUrl']),
                                              );
                                            }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
