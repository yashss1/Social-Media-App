import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_media/DashBoard%20Screens/home.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/model/blog_comment_model.dart';

import '../constants.dart';

class Blogs extends StatefulWidget {
  const Blogs({Key? key}) : super(key: key);

  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  TextEditingController post = TextEditingController();
  bool showSpinner = false;

  void addIntoFirebase() async {
    setState(() {
      showSpinner = true;
    });

    FirebaseFirestore.instance.collection('Blogs').add({
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
      FirebaseFirestore.instance.collection('Blogs').doc(documentId).update({
        'blogId': documentId,
      });
      setState(() {
        showSpinner = false;
        post.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Blog Added",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    });
  }

  deletePost(String blogId) async {
    // print("Delete Post button pressed");
    setState(() {
      showSpinner = true;
    });
    Navigator.pop(context);

    //Deleting Likes Collection
    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    var collection =
        instance.collection('Blogs').doc(blogId).collection("Likes");
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();

    //Deleting Likes Collection
    final instance2 = FirebaseFirestore.instance;
    final batch2 = instance2.batch();
    var collection2 =
        instance2.collection('Blogs').doc(blogId).collection("Comments");
    var snapshots2 = await collection2.get();
    for (var doc in snapshots2.docs) {
      batch2.delete(doc.reference);
    }
    await batch2.commit();

    // Deleting the Post Document
    await FirebaseFirestore.instance.collection("Blogs").doc(blogId).delete();
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
                      "Are you Sure you want to delete this Blog ?",
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
          body: Container(
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
                      Row(
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
                          SizedBox(width: 25),
                          const Text(
                            'Blogs',
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
                SizedBox(height: 30),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 12),
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
                                            right: 20,
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      color: Color.fromRGBO(
                                          255, 79, 90, 0.800000011920929),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Publish',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
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
                          // BlogComment(
                          //     dp: 'assets/images/Ellipse111.png',
                          //     commen:
                          //         'My mum just visited us today, the kids are on the moon',
                          //     id: '@dannygloves',
                          //     name: 'Danny Gloves'),
                          // SizedBox(height: 20),
                          // BlogComment(
                          //     dp: 'assets/images/Ellipse111.png',
                          //     commen:
                          //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. At tincidunt volutpat eget luctus. Ornare ipsum fermentum nunc purus et ac elementum mauris. Leo sapien feugiat vel vitae, cursus vel. Gravida nulla arcu suspendisse bibendum. Volutpat lorem arcu vulputate ipsum auctor nibh ultrices. Nisi purus bibendum magna lectus aliquam tellus aliquet. Amet eget nascetur augue accumsan et. Elementum volutpat, ac purus nibh tortor. Eget sed augue habitasse felis nunc sit. Faucibus et facilisis non volutpat et. Eget sit ipsum ullamcorper commodo rhoncus ut.',
                          //     id: '@royjessy',
                          //     name: 'Jessy Roy'),
                          // SizedBox(height: 20),
                          // BlogComment(
                          //     dp: 'assets/images/Ellipse111.png',
                          //     commen:
                          //         'My mum just visited us today, the kids are on the moon',
                          //     id: '@dannygloves',
                          //     name: 'Danny Gloves'),
                          // SizedBox(height: 20),
                          // BlogComment(
                          //     dp: 'assets/images/Ellipse111.png',
                          //     commen:
                          //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. At tincidunt volutpat eget luctus. Ornare ipsum fermentum nunc purus et ac elementum mauris. Leo sapien feugiat vel vitae, cursus vel. Gravida nulla arcu suspendisse bibendum. Volutpat lorem arcu vulputate ipsum auctor nibh ultrices. Nisi purus bibendum magna lectus aliquam tellus aliquet. Amet eget nascetur augue accumsan et. Elementum volutpat, ac purus nibh tortor. Eget sed augue habitasse felis nunc sit. Faucibus et facilisis non volutpat et. Eget sit ipsum ullamcorper commodo rhoncus ut.',
                          //     id: '@royjessy',
                          //     name: 'Jessy Roy'),
                          Container(
                            height: MediaQuery.of(context).size.height,
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('Blogs')
                                    .orderBy('createdAt', descending: true)
                                    .snapshots(),
                                builder: (ctx,
                                    AsyncSnapshot notificationsSnapshots) {
                                  if (notificationsSnapshots.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  final list =
                                      notificationsSnapshots.data!.docs;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Stack(
                                            children: [
                                              BlogComment(
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
                                                                    ['blogId']),
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
                                          if (index == list.length - 1)
                                            SizedBox(height: 80),
                                        ],
                                      );
                                    },
                                  );
                                }),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
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
