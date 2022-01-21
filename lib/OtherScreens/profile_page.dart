import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_media/Nav%20Drawer%20Screens/music.dart';
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
  bool showSpinner = false;
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
      FirebaseFirestore.instance
          .collection('Following')
          .doc(UserDetails.uid)
          .set({
        'Following': FieldValue.arrayUnion([
          {
            'UID': widget.array[widget.index]['Info']['Uid'],
          }
        ])
      }).then((value) {
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
      }).then((value) {
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
    }

    // Adding my UID in this UID's Follower Collection
    var _doc1 = await FirebaseFirestore.instance
        .collection("Followers")
        .doc(UserDetails.uid)
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
      }).then((value) {
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
      }).then((value) {
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
    }).then((value) {
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
    }
    // print(arrayFriend);
    for (var i = 0; i < arrayFriend.length; i++) {
      if (arrayFriend[i]['UID'] == widget.array[widget.index]['Info']['Uid']) {
        // print("Got it");
        setState(() {
          followStatus = "Following";
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Checking whether this UID is already my friend
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      checkFriend();
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
                              Container(
                                width: deviceWidth,
                                height: deviceHeight * 0.25,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(196, 196, 196, 1),
                                  // image: DecorationImage(
                                  //     image: AssetImage(
                                  //         'assets/images/Rectangle10 (1).png'),
                                  //     fit: BoxFit.fitWidth),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          "${widget.array[widget.index]['Info']['BgPhotoUrl']}"),
                                      fit: BoxFit.fitWidth),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 125,
                                        height: 122,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(196, 196, 196, 1),
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  "${widget.array[widget.index]['Info']['ProfilePhotoUrl']}"),
                                              fit: BoxFit.fitWidth),
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(125, 122)),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                    children: const [
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
                                        '0 People',
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
                                    'Friends',
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
                              const Text(
                                '854 friends',
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
                              SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: const [
                                    FriendModel(
                                        name: 'Alex John',
                                        img: 'assets/images/Rectangle12.png'),
                                    SizedBox(width: 20),
                                    FriendModel(
                                        name: 'Martin',
                                        img: 'assets/images/Rectangle13.png'),
                                    SizedBox(width: 20),
                                    FriendModel(
                                        name: 'Shreya Roy',
                                        img: 'assets/images/Rectangle14.png'),
                                    SizedBox(width: 20),
                                    FriendModel(
                                        name: 'Mila John',
                                        img: 'assets/images/Rectangle15.png'),
                                    SizedBox(width: 20),
                                  ],
                                ),
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
