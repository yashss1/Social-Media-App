import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/Services/notification_helper.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ChatTextFieldGrp extends StatefulWidget {
  const ChatTextFieldGrp(
      {Key? key, this.array, this.myIndex, this.chatRoomId, this.grpName})
      : super(key: key);

  final array, myIndex, chatRoomId, grpName;

  @override
  _ChatTextFieldGrpState createState() => _ChatTextFieldGrpState();
}

class _ChatTextFieldGrpState extends State<ChatTextFieldGrp> {
  TextEditingController message = TextEditingController();

  String msg = "";

  void onSendMessage() async {
    if (message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "Message": message.text,
        "SendBy": UserDetails.uid,
        "Type": "Text",
        "Time": FieldValue.serverTimestamp(),
        "ChatRoomId": widget.chatRoomId,
        "IsGroup": "Yes",
        "UserIdx": widget.myIndex,
      };
      msg = message.text;
      message.clear();
      var chatId;
      await FirebaseFirestore.instance
          .collection('ChatRooms')
          .doc(widget.chatRoomId)
          .collection('Chats')
          .add(messages)
          .then((value) {
        chatId = value.id;
      });

      await FirebaseFirestore.instance
          .collection('ChatRooms')
          .doc(widget.chatRoomId)
          .collection('Chats')
          .doc(chatId)
          .update({"ChatId": chatId});

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(UserDetails.uid)
          .collection("LastChat")
          .doc(widget.chatRoomId)
          .set({
        "GroupName": widget.grpName,
        "LastMsg": message.text,
        "Type": "Normal Message",
        "Time": FieldValue.serverTimestamp(),
        "ChatRoomId": widget.chatRoomId,
        "IsGroup": "Yes",
      });

      //for loop lav for all members except u
      for (int i = 0; i < widget.array.length; i++) {
        if (widget.myIndex == i)
          continue;
        else {
          await NotificationHelper()
              .getTokenForChatSent(widget.array[i]['Info']['Uid'], msg);

          await FirebaseFirestore.instance
              .collection("Users")
              .doc(widget.array[i]['Info']['Uid'])
              .collection("LastChat")
              .doc(widget.chatRoomId)
              .set({
            "GroupName": widget.grpName,
            "LastMsg": message.text,
            "Type": "Normal Message",
            "Time": FieldValue.serverTimestamp(),
            "ChatRoomId": widget.chatRoomId,
            "IsGroup": "Yes",
          });
        }
      }
    } else {
      print("Enter Some Text");
    }
  }

  //ImageSend
  //Photos
  late File _pickedImage;
  var isPicked = false;

  void getImage(ImageSource imageSource) async {
    ImagePicker imagePicker = new ImagePicker();
    await imagePicker
        .pickImage(
      source: imageSource,
      imageQuality: 75,
    )
        .then((value) {
      if (value != null) {
        _pickedImage = File(value.path);
        uploadImage().then((value) => print("Image Uploaded"));
      }
    });
  }

  //Upload the Image
  String imageUrl = "";

  Future uploadImage() async {
    int status = 1;
    var documentId;
    FirebaseFirestore.instance
        .collection('ChatRooms')
        .doc(widget.chatRoomId)
        .collection('Chats')
        .add({
      "Message": message.text,
      "SendBy": UserDetails.uid,
      "Type": "Image",
      "Time": FieldValue.serverTimestamp(),
      "ChatRoomId": widget.chatRoomId,
      "IsGroup": "Yes",
      "UserIdx": widget.myIndex,
    }).then((value) async {
      // print(value);
      documentId = value.id;
    });

    var time = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('GrpChatImages')
        .child('$time');

    var uploadTask = await ref.putFile(_pickedImage).catchError((error) async {
      await FirebaseFirestore.instance
          .collection('ChatRooms')
          .doc(widget.chatRoomId)
          .collection('Chats')
          .doc(documentId)
          .delete();
      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('ChatRooms')
          .doc(widget.chatRoomId)
          .collection('Chats')
          .doc(documentId)
          .update({"Message": imageUrl, "ChatId": documentId});

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(UserDetails.uid)
          .collection("LastChat")
          .doc(widget.chatRoomId)
          .set({
        "GroupName": widget.grpName,
        "LastMsg": "Image..",
        "Type": "Normal Image Message",
        "Time": FieldValue.serverTimestamp(),
        "ChatRoomId": widget.chatRoomId,
        "IsGroup": "Yes",
      });

      //for loop lav for all members except u
      for (int i = 0; i < widget.array.length; i++) {
        if (widget.myIndex == i)
          continue;
        else {
          await NotificationHelper()
              .getTokenForChatSent(widget.array[i]['Info']['Uid'], "Photo");

          await FirebaseFirestore.instance
              .collection("Users")
              .doc(widget.array[i]['Info']['Uid'])
              .collection("LastChat")
              .doc(widget.chatRoomId)
              .set({
            "GroupName": widget.grpName,
            "LastMsg": "Image..",
            "Type": "Normal Image Message",
            "Time": FieldValue.serverTimestamp(),
            "ChatRoomId": widget.chatRoomId,
            "IsGroup": "Yes",
          });
        }
      }

      // print(imageUrl);
    }
  }

  //Bottom Modal Sheet for Camera
  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (builder) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(true);
          },
          child: Container(
            color: Colors.white,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choose an option to send Image',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: InkWell(
                    onTap: () {
                      getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.camera,
                          color: Colors.pink,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Camera',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: InkWell(
                    onTap: () {
                      getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.image,
                          color: Colors.pink,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Gallery',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.pink,
            ),
            onPressed: () {
              buildShowModalBottomSheet(context);
            },
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.mic,
              color: Colors.pink,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all()),
              child: TextField(
                textInputAction: TextInputAction.send,
                controller: message,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10),
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Send a message',
                    hintStyle: TextStyle(
                      color: Colors.blueGrey,
                    )),
                onEditingComplete: () {},
                onChanged: (val) {
                  setState(() {});
                },
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              onSendMessage();
            },
            icon: const Icon(
              Icons.send,
              color: Colors.pink,
            ),
          )
        ],
      ),
    );
  }
}
