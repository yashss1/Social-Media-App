import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/constants.dart';

class ChatMesssages extends StatefulWidget {
  const ChatMesssages({Key? key, this.array, this.index, this.chatRoomId})
      : super(key: key);

  final array, index, chatRoomId;

  @override
  _ChatMesssagesState createState() => _ChatMesssagesState();
}

class _ChatMesssagesState extends State<ChatMesssages> {
  String text = "sdsadsa @yashss1", uid = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('ChatRooms')
          .doc(widget.chatRoomId)
          .collection('Chats')
          .orderBy("Time", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data != null) {
          return ListView.builder(
            reverse: true,
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> map =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              // print(map);
              return chatBubble(
                mp: map,
                array: widget.array,
                index: widget.index,
                isSender: map['SendBy'] == UserDetails.name,
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class chatBubble extends StatelessWidget {
  final mp, array, index;
  final bool isSender;
  final Function()? ontap;

  const chatBubble({
    Key? key,
    this.ontap,
    required this.isSender,
    this.mp,
    this.array,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isSender == false
                    ? Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(100, 94, 94, 1),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  array[index]['Info']['ProfilePhotoUrl']),
                              fit: BoxFit.fitWidth),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(36, 36)),
                        ),
                      )
                    : SizedBox(),
                Column(
                  children: [
                    BubbleNormal(
                      text: mp['Message'],
                      isSender: false,
                      color: isSender == true
                          ? pink
                          : Color.fromRGBO(244, 244, 244, 1),
                      tail: false,
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: isSender == true ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                isSender == true
                    ? Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(100, 94, 94, 1),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  UserDetails.profilePhotoUrl!),
                              fit: BoxFit.fitWidth),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(36, 36)),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
