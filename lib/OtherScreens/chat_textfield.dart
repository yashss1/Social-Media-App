import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/Services/notification_helper.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ChatTextField extends StatefulWidget {
  const ChatTextField({Key? key, this.array, this.index, this.chatRoomId})
      : super(key: key);

  final array, index, chatRoomId;

  @override
  _ChatTextFieldState createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  TextEditingController message = TextEditingController();

  void onSendMessage() async {
    if (message.text.isNotEmpty && message.text.length != 0) {
      await NotificationHelper().getTokenForChatSent(
          widget.array[widget.index]['Info']['Uid'], message.text);

      Map<String, dynamic> messages = {
        "SendBy": UserDetails.name,
        "Message": message.text,
        "Type": "Text",
        "Time": FieldValue.serverTimestamp(),
      };

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
          .collection('ChatRooms')
          .doc(widget.chatRoomId)
          .set({"isGroup": "No"});

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(UserDetails.uid)
          .collection("LastChat")
          .doc(widget.array[widget.index]['Info']['Uid'])
          .set({
        "LastMsg": messages['Message'],
        "Type": messages['Type'],
        "Time": messages['Time'],
        "ChatRoomId": widget.chatRoomId,
        "ChatWith": widget.array[widget.index]['Info']['Uid'],
        "IsGroup": "No",
      });

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.array[widget.index]['Info']['Uid'])
          .collection("LastChat")
          .doc(UserDetails.uid)
          .set({
        "LastMsg": messages['Message'],
        "Type": messages['Type'],
        "Time": messages['Time'],
        "ChatRoomId": widget.chatRoomId,
        "ChatWith": UserDetails.uid,
        "IsGroup": "No",
      });
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
      "SendBy": UserDetails.name,
      "Message": "",
      "Type": "Image",
      "Time": FieldValue.serverTimestamp(),
    }).then((value) async {
      // print(value);
      documentId = value.id;
    });

    var time = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('ChatImages')
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
          .doc(widget.array[widget.index]['Info']['Uid'])
          .set({
        "LastMsg": "Image",
        "Type": "Image",
        "Time": FieldValue.serverTimestamp(),
        "ChatRoomId": widget.chatRoomId,
        "ChatWith": widget.array[widget.index]['Info']['Uid'],
      });

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.array[widget.index]['Info']['Uid'])
          .collection("LastChat")
          .doc(UserDetails.uid)
          .set({
        "LastMsg": "Image",
        "Type": "Image",
        "Time": FieldValue.serverTimestamp(),
        "ChatRoomId": widget.chatRoomId,
        "ChatWith": UserDetails.uid,
      });

      await NotificationHelper().getTokenForChatSent(
          widget.array[widget.index]['Info']['Uid'], "Photo");
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
