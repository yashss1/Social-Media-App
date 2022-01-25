import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/constants.dart';

class ChatMesssages extends StatefulWidget {
  const ChatMesssages({Key? key}) : super(key: key);

  @override
  _ChatMesssagesState createState() => _ChatMesssagesState();
}

class _ChatMesssagesState extends State<ChatMesssages> {
  String text = "sdsadsa @yashss1", uid = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            chatBubble(
                image: UserDetails.profilePhotoUrl!,
                message: "SDsdddddddjksmnnnnnnnnnnnsdsd",
                isSender: false),
            chatBubble(
                image: UserDetails.profilePhotoUrl!,
                message:
                    "SDdfffffffffffbbbbbbbbbsssssssssssssssssssssssssssssssssssssssssssssssssssssssaaaaaaaaiiiiiiiiiisdsdsd",
                isSender: true),
            SizedBox(height: 50),

          ],
        ),
      ),
    );
  }
}

class chatBubble extends StatelessWidget {
  final String image, message;
  final bool isSender;
  final Function()? ontap;

  const chatBubble({
    Key? key,
    this.ontap,
    required this.image,
    required this.message,
    required this.isSender,
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
                              image: CachedNetworkImageProvider("${image}"),
                              fit: BoxFit.fitWidth),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(36, 36)),
                        ),
                      )
                    : SizedBox(),
                Column(
                  children: [
                    BubbleNormal(
                      text: message,
                      isSender: false,
                      color: isSender == true
                          ? pink
                          : Color.fromRGBO(244, 244, 244, 1),
                      tail: true,
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
                              image: CachedNetworkImageProvider("${image}"),
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
