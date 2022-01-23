// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:social_media/DashBoard%20Screens/search_page.dart';
// import 'package:social_media/OtherScreens/profile_page.dart';
// import 'package:social_media/Services/user_details.dart';
// import 'package:social_media/constants.dart';
// import 'package:social_media/model/post_model.dart';
// import 'package:social_media/model/story_model.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   TextEditingController post = TextEditingController();
//   bool showSpinner = false;
//
//   void addIntoFirebase() async {
//     setState(() {
//       showSpinner = true;
//     });
//
//     var _doc = await FirebaseFirestore.instance
//         .collection("Posts")
//         .doc(UserDetails.uid)
//         .get();
//     bool docStatus = _doc.exists;
//     // print(docStatus);
//     if (docStatus == false) {
//       FirebaseFirestore.instance.collection('Posts').doc(UserDetails.uid).set({
//         'Posts': FieldValue.arrayUnion([
//           {
//             'Name': UserDetails.name,
//             'Uid': UserDetails.uid,
//             'ProfilePhotoUrl': UserDetails.profilePhotoUrl,
//             'UserName': UserDetails.username,
//             'Post': post.text,
//             'LikeType': 0,
//             'createdAt': Timestamp.now(),
//           }
//         ])
//       }).then((value) {
//         setState(() {
//           showSpinner = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               "Post Added",
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//         );
//       });
//     } else {
//       FirebaseFirestore.instance
//           .collection('Posts')
//           .doc(UserDetails.uid)
//           .update({
//         'Posts': FieldValue.arrayUnion([
//           {
//             'Name': UserDetails.name,
//             'Uid': UserDetails.uid,
//             'ProfilePhotoUrl': UserDetails.profilePhotoUrl,
//             'UserName': UserDetails.username,
//             'Post': post.text,
//             'LikeType': 0,
//             'createdAt': Timestamp.now(),
//           }
//         ])
//       }).then((value) {
//         setState(() {
//           post.clear();
//           showSpinner = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               "Post Added",
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//         );
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final deviceWidth = MediaQuery.of(context).size.width;
//     final deviceHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: ModalProgressHUD(
//         inAsyncCall: showSpinner,
//         child: Container(
//           width: deviceWidth,
//           height: deviceHeight,
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 width: deviceWidth,
//                 height: 70,
//                 color: Colors.white,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       splashColor: Colors.pink,
//                       onTap: () {
//                         Scaffold.of(context).openDrawer();
//                       },
//                       child: const Icon(
//                         Icons.notes,
//                         size: 28,
//                       ),
//                     ),
//                     const Text(
//                       'Signature',
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                           color: Color.fromRGBO(255, 79, 90, 1),
//                           fontFamily: 'Lato',
//                           fontSize: 23,
//                           letterSpacing:
//                           0 /*percentages not used in flutter. defaulting to zero*/,
//                           fontWeight: FontWeight.normal,
//                           height: 1),
//                     ),
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.notifications_none,
//                           size: 30,
//                         ),
//                         SizedBox(width: 10),
//                         Container(
//                             width: 34.14285659790039,
//                             height: 32.590911865234375,
//                             decoration: BoxDecoration(
//                               color: Color.fromRGBO(196, 196, 196, 1),
//                               image: DecorationImage(
//                                   image: CachedNetworkImageProvider(
//                                       "${UserDetails.profilePhotoUrl}"),
//                                   fit: BoxFit.fitWidth),
//                               borderRadius: BorderRadius.all(Radius.elliptical(
//                                   34.14285659790039, 32.590911865234375)),
//                             ))
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   child: SingleChildScrollView(
//                     physics: BouncingScrollPhysics(),
//                     child: Column(
//                       children: [
//                         SizedBox(height: 15),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           physics: const BouncingScrollPhysics(),
//                           child: Row(
//                             children: const [
//                               Story1(
//                                   stry: 'assets/images/Rectangle16.png',
//                                   img: 'assets/images/Rectangle12.png'),
//                               Story1(
//                                   stry: 'assets/images/Rectangle17.png',
//                                   img: 'assets/images/Rectangle13.png'),
//                               Story1(
//                                   stry: 'assets/images/Rectangle18.png',
//                                   img: 'assets/images/Rectangle14.png'),
//                               Story1(
//                                   stry: 'assets/images/Rectangle19.png',
//                                   img: 'assets/images/Rectangle15.png'),
//                               Story1(
//                                   stry: 'assets/images/Rectangle20.png',
//                                   img: 'assets/images/Rectangle14.png'),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 25),
//                         Container(
//                           margin: EdgeInsets.symmetric(horizontal: 16),
//                           width: deviceWidth,
//                           decoration: BoxDecoration(
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(10),
//                               topRight: Radius.circular(10),
//                               bottomLeft: Radius.circular(10),
//                               bottomRight: Radius.circular(10),
//                             ),
//                             border: Border.all(
//                               color: const Color.fromRGBO(0, 0, 0, 1),
//                               width: 1,
//                             ),
//                           ),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                       margin: const EdgeInsets.only(
//                                           left: 20,
//                                           right: 50,
//                                           top: 15,
//                                           bottom: 15),
//                                       width: 52,
//                                       height: 52,
//                                       decoration: BoxDecoration(
//                                         color: Color.fromRGBO(100, 94, 94, 1),
//                                         image: DecorationImage(
//                                             image: CachedNetworkImageProvider(
//                                                 "${UserDetails.profilePhotoUrl}"),
//                                             fit: BoxFit.fitWidth),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.elliptical(52, 52)),
//                                       )),
//                                   Container(
//                                     width: deviceWidth * .55,
//                                     child: TextField(
//                                       controller: post,
//                                       textAlign: TextAlign.left,
//                                       maxLines: 3,
//                                       decoration: InputDecoration(
//                                         hintText: "Something in your mind",
//                                       ),
//                                       style: TextStyle(
//                                           color: Color.fromRGBO(
//                                               0, 0, 0, 0.4699999988079071),
//                                           fontFamily: 'Lato',
//                                           fontSize: 18,
//                                           letterSpacing:
//                                           0 /*percentages not used in flutter. defaulting to zero*/,
//                                           fontWeight: FontWeight.normal,
//                                           height: 1),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               SizedBox(height: 25),
//                               // Row(
//                               //   mainAxisAlignment: MainAxisAlignment.center,
//                               //   children: const [
//                               //     Text(
//                               //       '😃',
//                               //       style: TextStyle(fontSize: 25),
//                               //     ),
//                               //     SizedBox(width: 5),
//                               //     Text(
//                               //       '😍',
//                               //       style: TextStyle(fontSize: 25),
//                               //     ),
//                               //     SizedBox(width: 5),
//                               //     Text(
//                               //       '😡',
//                               //       style: TextStyle(fontSize: 25),
//                               //     ),
//                               //     SizedBox(width: 5),
//                               //     Text(
//                               //       '👍',
//                               //       style: TextStyle(fontSize: 25),
//                               //     ),
//                               //     SizedBox(width: 5),
//                               //     Text(
//                               //       '👎',
//                               //       style: TextStyle(fontSize: 25),
//                               //     ),
//                               //   ],
//                               // ),
//                               // SizedBox(height: 20),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               InkWell(
//                                 onTap: () async {
//                                   if (post.text == null ||
//                                       post.text.length == 0) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         content: Text(
//                                           "Please Write a Post",
//                                           style: TextStyle(fontSize: 16),
//                                         ),
//                                       ),
//                                     );
//                                   } else {
//                                     addIntoFirebase();
//                                   }
//                                 },
//                                 child: Container(
//                                   width: 107,
//                                   height: 40,
//                                   decoration: const BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(6),
//                                       topRight: Radius.circular(6),
//                                       bottomLeft: Radius.circular(6),
//                                       bottomRight: Radius.circular(6),
//                                     ),
//                                     color: Color.fromRGBO(
//                                         255, 79, 90, 0.800000011920929),
//                                   ),
//                                   child: const Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       'Publish',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           color:
//                                           Color.fromRGBO(255, 255, 255, 1),
//                                           fontFamily: 'Lato',
//                                           fontSize: 20,
//                                           letterSpacing:
//                                           0 /*percentages not used in flutter. defaulting to zero*/,
//                                           fontWeight: FontWeight.normal,
//                                           height: 1),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 25),
//                         CommentModel(),
//                         StreamBuilder(
//                             stream: FirebaseFirestore.instance
//                                 .collection('Users')
//                                 .snapshots(),
//                             builder: (ctx, AsyncSnapshot snaps) {
//                               if (snaps.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return Center(
//                                   child: CircularProgressIndicator(),
//                                 );
//                               }
//                               final _snap = snaps.data!.docs;
//                               return _snap.length == 0
//                                   ? Container(
//                                 color: Colors.pink,
//                                 width: MediaQuery.of(context).size.width,
//                                 padding: EdgeInsets.only(
//                                   top:
//                                   MediaQuery.of(context).size.height *
//                                       .3,
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Text(
//                                       "WE'RE SORRY",
//                                     ),
//                                     Center(
//                                       child: Text(
//                                         "There is Nothing here...",
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                                   : Container(
//                                 height:
//                                 MediaQuery.of(context).size.height,
//                                 child: ListView.builder(
//                                     physics: BouncingScrollPhysics(),
//                                     itemCount: _snap.length,
//                                     itemBuilder: (context, index) {
//                                       return item(
//                                         image: _snap[index]['Info']
//                                         ['ProfilePhotoUrl'],
//                                         name: _snap[index]['Info']
//                                         ['Name'],
//                                         username: _snap[index]['Info']
//                                         ['Username'],
//                                         ontap: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       ProfilePage(
//                                                         array: _snap,
//                                                         index: index,
//                                                       )));
//                                         },
//                                       );
//                                     }),
//                               );
//                             }),
//                         SizedBox(height: 100),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
