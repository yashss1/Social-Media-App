import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecentChatGrp extends StatefulWidget {
  const RecentChatGrp(
      {Key? key,  this.ontap, required this.lastMsg, required this.grpName, required this.chatRoomId})
      : super(key: key);

  final String grpName, lastMsg, chatRoomId;
  final Function()? ontap;

  @override
  _RecentChatGrpState createState() => _RecentChatGrpState();
}

class _RecentChatGrpState extends State<RecentChatGrp> {
  bool dataBhetla = false;
  String grpName = "";

  Future getData() async {}

  @override
  void initState() {
    super.initState();

    getData().then((value) async {
      var _doc = await FirebaseFirestore.instance
          .collection("ChatRooms")
          .doc(widget.chatRoomId)
          .get();

      setState(() {
        grpName = _doc['GroupName'];
        dataBhetla = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return dataBhetla == false
        ? Container()
        : InkWell(
            onTap: widget.ontap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              // width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(100, 94, 94, 1),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  "https://freesvg.org/img/abstract-user-flat-4.png"),
                              fit: BoxFit.fitWidth),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(36, 36)),
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${grpName}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: 'Lato',
                                fontSize: 17,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                          // SizedBox(height: 5),
                          // Text(
                          //   '@${array[0]['Info']['Username']}',
                          //   textAlign: TextAlign.left,
                          //   style: TextStyle(
                          //       color:
                          //           Color.fromRGBO(0, 0, 0, 0.8100000023841858),
                          //       fontFamily: 'Lato',
                          //       fontSize: 15,
                          //       letterSpacing:
                          //           0 /*percentages not used in flutter. defaulting to zero*/,
                          //       fontWeight: FontWeight.normal,
                          //       height: 1),
                          // ),
                          SizedBox(height: 10),
                          Text(
                            '${widget.lastMsg}...',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color:
                                    Color.fromRGBO(0, 0, 0, 0.8100000023841858),
                                fontFamily: 'Lato',
                                fontSize: 13,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
