import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../Services/user_details.dart';
import '../constants.dart';
import '../textfield.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'add_product2.dart';

class AddVideo extends StatefulWidget {
  const AddVideo({Key? key}) : super(key: key);

  @override
  _AddVideoState createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
  TextEditingController videoname = TextEditingController();
  TextEditingController tags = TextEditingController();

  // TextEditingController location = TextEditingController();
  // TextEditingController email = TextEditingController();

  //Video
  bool showSpinner1 = false;
  bool showSpinner = false;
  late var pickedVideo;
  String thumbnailImage = "";

  Future uploadVideo() async {
    //Upload
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    String Time = "${time}";
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('VideoPost')
        .child('$Time');

    await ref.putFile(pickedVideo);
    String videoUrl = await ref.getDownloadURL();
    print(videoUrl);

    //Now putting in Firestore
    FirebaseFirestore.instance.collection('VideoPost').add({
      'createdAt': Timestamp.now(),
      'AddedBy': UserDetails.uid,
      'Username': UserDetails.username,
      'VideoUrl': videoUrl,
      'createdAt': Timestamp.now(),
      'NumberOfComments': 0,
      'VideoName': videoname.text,
      'Name': UserDetails.name,
      'Tags': tags.text,
      'ThumbnailImage': thumbnailImage,
      'ProfilePhotoUrl': UserDetails.profilePhotoUrl,
      'BgPhotoUrl': UserDetails.bgPhotoUrl,
    }).then((value) async {
      // print(value);
      var documentId = value.id;
      await FirebaseFirestore.instance
          .collection('VideoPost')
          .doc(documentId)
          .update({
        'videoId': documentId,
      }).then((value) async {});
      // await hashAdder(post.text, documentId).then((value) {
      //   setState(() {
      //     showSpinner1 = false;
      //   });
      // });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Video Added",
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

  Future pickVideo() async {
    setState(() {
      showSpinner1 = true;
    });
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4'],
    );
    if (result == null) return null;
    pickedVideo = File(result.paths.first!);
    print(pickedVideo);

    //Get the Thumbnail
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: pickedVideo.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );

    Uint8List? imageInUnit8List = thumbnail; // store unit8List image here ;
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(imageInUnit8List!);

    var time = DateTime.now().millisecondsSinceEpoch.toString();
    String Time = "${time}";
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('VideoPostThumbnail')
        .child('$Time');

    await ref.putFile(file);
    thumbnailImage = await ref.getDownloadURL();
    print(thumbnailImage);

    setState(() {
      showSpinner1 = false;
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
                        'Add Video',
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
                                Text("Video Name",
                                    style: myStyle(17, "Syne",
                                        fw: FontWeight.normal,
                                        color: Colors.black)),
                                SizedBox(
                                  height: 5,
                                ),
                                textfieldSmall(
                                    hint_text: 'Video Name',
                                    controller: videoname),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Tags",
                                    style: myStyle(17, "Syne",
                                        fw: FontWeight.normal,
                                        color: Colors.black)),
                                SizedBox(
                                  height: 5,
                                ),
                                textfieldSmall(
                                    hint_text: 'Tags', controller: tags),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Add Video",
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
                                        await pickVideo();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 11),
                                        width: 180,
                                        height: 280,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: 180,
                                              height: 250,
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
                                                  : thumbnailImage != ""
                                                      ? Container(
                                                          width: 180,
                                                          height: 250,
                                                          decoration:
                                                              BoxDecoration(
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    "$thumbnailImage"),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        )
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
                                      if (videoname.text == null ||
                                          videoname.text.length == 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Please Enter the Brand Name",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        );
                                      } else if (tags.text == null ||
                                          tags.text.length == 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Please Enter the Item Name",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        );
                                      } else if (pickedVideo == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Please Add a Video",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          showSpinner = true;
                                        });
                                        await uploadVideo();
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
