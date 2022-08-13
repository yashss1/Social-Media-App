import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentChat extends StatefulWidget {
  const RecentChat(
      {Key? key,
      required this.uid,
      this.ontap,
      required this.lastMsg,
      required this.lastMsgTime})
      : super(key: key);

  final String uid, lastMsg;
  final DateTime lastMsgTime;
  final Function()? ontap;

  @override
  _RecentChatState createState() => _RecentChatState();
}

class _RecentChatState extends State<RecentChat> {
  List array = [];
  bool dataBhetla = false;

  Future getData() async {}

  String date = "", time = "";

  @override
  void initState() {
    super.initState();

    getData().then((value) async {
      var _doc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.uid)
          .get();
      array.add(_doc);
      setState(() {
        dataBhetla = true;
      });
      print(array);
    });

    DateTime myDateTime = widget.lastMsgTime;
    DateTime currentDateTime = Timestamp.now().toDate();
    String formattedDateTime =
        DateFormat('dd-MM-yyyy – hh:mm a').format(myDateTime);
    String formattedDateTimecurr =
        DateFormat('dd-MM-yyyy – hh:mm a').format(currentDateTime);
    String s1 = formattedDateTime.substring(0, 10);
    String s2 = formattedDateTimecurr.substring(0, 10);

    String formatDate = DateFormat.yMMMEd().format(myDateTime);
    // print(formatDate);
    if (s1 == s2) {
      date = "Today";
      time = formattedDateTime.substring(13);
    } else {
      date = formatDate.substring(4, 11);
      time = formattedDateTime.substring(13);
    }
  }

  @override
  Widget build(BuildContext context) {
    return dataBhetla == false
        ? Container()
        : InkWell(
            onTap: widget.ontap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              height: 80,
              // width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(100, 94, 94, 1),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              "${array[0]['Info']['ProfilePhotoUrl']}"),
                          fit: BoxFit.fitWidth),
                      borderRadius: BorderRadius.all(Radius.elliptical(36, 36)),
                    ),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${array[0]['Info']['Name']}',
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
                            SizedBox(height: 5),
                            Text(
                              '@${array[0]['Info']['Username']}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.8100000023841858),
                                  fontFamily: 'Lato',
                                  fontSize: 15,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${widget.lastMsg}...',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.8100000023841858),
                                  fontFamily: 'Lato',
                                  fontSize: 13,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${date}",
                                  textAlign: TextAlign.left,
                                  maxLines: 5,
                                  style: TextStyle(
                                      color: Color.fromRGBO(
                                          0, 0, 0, 0.949999988079071),
                                      fontFamily: 'Lato',
                                      fontSize: 12,
                                      letterSpacing:
                                          0 /*percentages not used in flutter. defaulting to zero*/,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "${time}",
                                  textAlign: TextAlign.left,
                                  maxLines: 5,
                                  style: TextStyle(
                                      color: Color.fromRGBO(
                                          0, 0, 0, 0.949999988079071),
                                      fontFamily: 'Lato',
                                      fontSize: 12,
                                      letterSpacing:
                                          0 /*percentages not used in flutter. defaulting to zero*/,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                ),
                              ],
                            ),
                            Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
