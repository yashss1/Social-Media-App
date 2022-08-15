import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../Services/user_details.dart';
import '../constants.dart';
import '../textfield.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'add_product2.dart';

class AddMusic extends StatefulWidget {
  const AddMusic({Key? key}) : super(key: key);

  @override
  _AddMusicState createState() => _AddMusicState();
}

class _AddMusicState extends State<AddMusic> {
  TextEditingController musicname = TextEditingController();
  TextEditingController singer = TextEditingController();

  // TextEditingController location = TextEditingController();
  // TextEditingController email = TextEditingController();

  bool musicAdded = false;
  bool imagePicked = false;

  //Video
  bool showSpinner = false;
  bool showSpinner1 = false;

  late File _pickedMusic;
  late File _pickedMusicImage;

  Future uploadMusic() async {
    //Upload
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    String Time = "${time}";
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('MusicPost')
        .child('$Time');

    await ref.putFile(_pickedMusic);
    String musicUrl = await ref.getDownloadURL();
    // String musicUrl = "";
    // print(musicUrl);

    var time1 = DateTime.now().millisecondsSinceEpoch.toString();
    String Time1 = "${time1}";
    firebase_storage.Reference ref1 = firebase_storage.FirebaseStorage.instance
        .ref('MusicPostImage')
        .child('$Time1');

    await ref1.putFile(_pickedMusicImage);
    String musicImageUrl = await ref1.getDownloadURL();
    print("Music Image Url : ${musicImageUrl}");

    //Now putting in Firestore
    FirebaseFirestore.instance.collection('MusicPost').add({
      'createdAt': Timestamp.now(),
      'AddedBy': UserDetails.uid,
      'Username': UserDetails.username,
      'musicUrl': musicUrl,
      'createdAt': Timestamp.now(),
      'NumberOfComments': 0,
      'Singer': singer.text,
      'MusicName': musicname.text,
      'Name': UserDetails.name,
      'MusicImage': musicImageUrl,
      'ProfilePhotoUrl': UserDetails.profilePhotoUrl,
      'BgPhotoUrl': UserDetails.bgPhotoUrl,
    }).then((value) async {
      // print(value);
      var documentId = value.id;
      await FirebaseFirestore.instance
          .collection('MusicPost')
          .doc(documentId)
          .update({
        'musicId': documentId,
      }).then((value) async {});
      // await hashAdder(post.text, documentId).then((value) {
      //   setState(() {
      //     showSpinner1 = false;
      //   });
      // });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Music Added",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
      setState(() {
        showSpinner = false;
      });
      Navigator.pop(context);
    });
  }

  Future _pickMusic() async {
    setState(() {
      showSpinner1 = true;
    });
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );
    if (result == null) return null;
    final _pickedMusic1 = File(result.paths.first!);
    print(_pickedMusic1);

    // ImagePicker imagePicker = new ImagePicker();
    // final pickedFile = await imagePicker.pickImage(
    //   source: ImageSource.gallery,
    //   imageQuality: 75,
    // );
    // // await _cropImage1(pickedImageFile!.path);
    setState(() {
      _pickedMusic = File(_pickedMusic1.path);
      showSpinner1 = false;
      musicAdded = true;
    });
  }

  Future _pickMusicImage() async {
    ImagePicker imagePicker = new ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    // await _cropImage1(pickedImageFile!.path);
    setState(() {
      _pickedMusicImage = File(pickedFile!.path);
      imagePicked = true;
      print(_pickedMusicImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [
            //       Color(0xff1F00FC),
            //       Colors.black,
            //       Colors.black,
            //     ],
            //   ),
            // ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 70),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.arrow_back, size: 30, color: pink),
                        ),
                      ),
                      Center(
                          child: Text(
                        'Add Music',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: pink,
                            fontFamily: 'Syne',
                            fontSize: 25,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      )),
                    ],
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Music Name",
                                    style: myStyle(17, "Syne",
                                        fw: FontWeight.normal,
                                        color: Colors.black)),
                                SizedBox(
                                  height: 5,
                                ),
                                textfieldSmall(
                                    hint_text: 'Music Name',
                                    controller: musicname),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Singer",
                                    style: myStyle(17, "Syne",
                                        fw: FontWeight.normal,
                                        color: Colors.black)),
                                SizedBox(
                                  height: 5,
                                ),
                                textfieldSmall(
                                    hint_text: 'Singer Name',
                                    controller: singer),
                                SizedBox(
                                  height: 10,
                                ),
                                // Text("Tags",
                                //     style: myStyle(17, "Syne",
                                //         fw: FontWeight.normal,
                                //         color: Colors.black)),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // textfieldSmall(
                                //     hint_text: 'Tags', controller: tags),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Add Music Cover",
                                    style: myStyle(17, "Syne",
                                        fw: FontWeight.normal,
                                        color: Colors.black)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _pickMusicImage();
                                      },
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .45,
                                          height: 181.4901885986328,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25),
                                              bottomLeft: Radius.circular(25),
                                              bottomRight: Radius.circular(25),
                                            ),
                                            gradient: LinearGradient(
                                                begin: Alignment(
                                                    -2.735211000005005e-16,
                                                    1.123778223991394),
                                                end: Alignment(
                                                    -1.123778223991394,
                                                    6.881157358895517e-17),
                                                colors: [
                                                  Colors.grey.shade400,
                                                  Colors.grey.shade200,
                                                ]),
                                            image: DecorationImage(
                                                image: imagePicked
                                                    ? FileImage(
                                                            _pickedMusicImage)
                                                        as ImageProvider
                                                    : AssetImage(
                                                        'assets/images/Rectangle500.png'),
                                                fit: BoxFit.cover),
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Add Music",
                                    style: myStyle(17, "Syne",
                                        fw: FontWeight.normal,
                                        color: Colors.black)),
                                SizedBox(
                                  height: 5,
                                ),
                                // textfieldNumber2(
                                //     hint_text: '\$0.00', controller: price),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Text("Short Description",
                                //     style: myStyle(17, "Syne",
                                //         fw: FontWeight.normal,
                                //         color: Colors.black)),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Container(
                                //   width: double.infinity,
                                //   height: 150,
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.only(
                                //       topLeft: Radius.circular(10),
                                //       topRight: Radius.circular(10),
                                //       bottomLeft: Radius.circular(10),
                                //       bottomRight: Radius.circular(10),
                                //     ),
                                //     color: Colors.grey.shade100,
                                //   ),
                                //   child: textfieldLarge(
                                //       hint_text:
                                //       'Include Details (Size, Condition, Year, etc.)',
                                //       controller: details),
                                // ),
                                // SizedBox(height: 10),
                                // // Text("Email for Buyers to Contact",
                                // //     style: myStyle(17, "Syne",
                                // //         fw: FontWeight.normal,
                                // //         color: Colors.black)),
                                // // SizedBox(
                                // //   height: 5,
                                // // ),
                                // // textfieldSmall(
                                // //     hint_text: 'Email', controller: email),
                                // // SizedBox(height: 10),
                                // Text("Video",
                                //     style: myStyle(17, "Syne",
                                //         fw: FontWeight.normal,
                                //         color: Colors.white)),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await _pickMusic();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 11),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .6,
                                        height: 60,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .6,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
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
                                                  : musicAdded == true
                                                      ? Center(
                                                          child: Icon(
                                                          Icons.done,
                                                          color: pink,
                                                          size: 30,
                                                        ))
                                                      : Center(
                                                          child: Icon(
                                                          Icons.add,
                                                          color: pink,
                                                          size: 30,
                                                        )),
                                            ),
                                            // Align(
                                            //   alignment: Alignment.bottomCenter,
                                            //   child: Container(
                                            //     width: 45,
                                            //     height: 45,
                                            //     decoration: BoxDecoration(
                                            //       color: Color.fromRGBO(
                                            //           100, 94, 94, 1),
                                            //       image: DecorationImage(
                                            //           image: CachedNetworkImageProvider(
                                            //               "${UserDetails.profilePhotoUrl}"),
                                            //           fit: BoxFit.cover),
                                            //       borderRadius:
                                            //           const BorderRadius.all(
                                            //               Radius.elliptical(
                                            //                   36, 36)),
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // // textfieldSmall(
                                // //     hint_text: 'Location',
                                // //     controller: location),
                                SizedBox(height: 50),
                                Container(
                                  alignment: Alignment.center,
                                  child: button(
                                    onPressed: () async {
                                      if (musicname.text == null ||
                                          musicname.text.length == 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Please Enter the Music Name",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        );
                                      } else if (imagePicked == false) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Please Upload Music Image",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        );
                                      } else if (musicAdded == false) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Please Add a Music",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          showSpinner = true;
                                        });
                                        await uploadMusic();
                                      }
                                    },
                                    child: Text("Next"),

                                    // ignore: prefer_const_constructors
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 30,
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
        ));
  }
}
