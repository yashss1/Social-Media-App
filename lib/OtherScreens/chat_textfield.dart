import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/Services/user_details.dart';

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
    if (message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "SendBy": UserDetails.name,
        "Message": message.text,
        "Type": "Text",
        "Time": FieldValue.serverTimestamp(),
      };

      message.clear();
      await FirebaseFirestore.instance
          .collection('ChatRooms')
          .doc(widget.chatRoomId)
          .collection('Chats')
          .add(messages);

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
      });
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.pink,
            ),
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
