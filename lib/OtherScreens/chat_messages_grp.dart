import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_full_image_screen/custom_full_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/constants.dart';

class ChatMesssagesGrp extends StatefulWidget {
  const ChatMesssagesGrp({Key? key, this.array, this.chatRoomId})
      : super(key: key);

  final array, chatRoomId;

  @override
  _ChatMesssagesGrpState createState() => _ChatMesssagesGrpState();
}

class _ChatMesssagesGrpState extends State<ChatMesssagesGrp> {
  String text = "sdsadsa @yashss1", uid = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  deleteChat(String chatId) async {
    Navigator.pop(context);

    // Deleting the Post Document
    await FirebaseFirestore.instance
        .collection('ChatRooms')
        .doc(widget.chatRoomId)
        .collection('Chats')
        .doc(chatId)
        .delete();
  }

  void handleClick(int item, String chatId) async {
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
                      "Are you Sure you want to delete this Chat ?",
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
                              await deleteChat(chatId);
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
              return Container(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onLongPress: () {
                    if (map['SendBy'] == UserDetails.uid)
                      handleClick(0, map['ChatId']);
                  },
                  child: chatBubble(
                    mp: map,
                    array: widget.array,
                    userIdx: map['UserIdx'],
                    isSender: map['SendBy'] == UserDetails.uid,
                  ),
                ),
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
  final mp, array, userIdx;
  final bool isSender;
  final Function()? ontap;

  const chatBubble({
    Key? key,
    this.ontap,
    required this.isSender,
    this.mp,
    this.array,
    this.userIdx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: mp['Type'] == "Text"
          ? Container(
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
                                        array[userIdx]['Info']
                                            ['ProfilePhotoUrl']),
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
                              color: isSender == true
                                  ? Colors.white
                                  : Colors.black,
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
            )
          : Container(
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
                                        array[userIdx]['Info']
                                            ['ProfilePhotoUrl']),
                                    fit: BoxFit.cover),
                                borderRadius:
                                    BorderRadius.all(Radius.elliptical(36, 36)),
                              ),
                            )
                          : SizedBox(),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Container(
                          alignment:
                              mp['Message'] != "" ? null : Alignment.center,
                          height: MediaQuery.of(context).size.height / 2.5,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(color: Colors.grey, spreadRadius: 3),
                            ],
                          ),
                          child: mp['Message'] != ""
                              ? ImageCachedFullscreen(
                                  imageUrl: mp['Message'],
                                  imageWidth: 125,
                                  imageHeight: 122,
                                  imageBorderRadius: 10,
                                  imageFit: BoxFit.cover,
                                  imageDetailsHeight: 450,
                                  imageDetailsWidth: 450,
                                  withHeroAnimation: true,
                                  placeholder: Container(
                                    child: Icon(Icons.check),
                                  ),
                                  errorWidget: Container(
                                    child: Icon(Icons.error),
                                  ),
                                  placeholderDetails: Container(),
                                )
                              // ? Image.network(
                              //     mp['Message'],
                              //     fit: BoxFit.cover,
                              //     height: 50,
                              //     width: 50,
                              //   )
                              : CircularProgressIndicator(),
                        ),
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
                                    fit: BoxFit.cover),
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
