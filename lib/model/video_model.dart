import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_media/constants.dart';

import '../DashBoard Screens/user_page.dart';
import '../OtherScreens/profile_page.dart';
import '../OtherScreens/video_screen.dart';
import '../Services/user_details.dart';

class VideoModel extends StatefulWidget {
  const VideoModel({Key? key, this.array, this.index}) : super(key: key);

  final array, index;

  @override
  State<VideoModel> createState() => _VideoModelState();
}

class _VideoModelState extends State<VideoModel> {
  String date = "", time = "";

  @override
  void initState() {
    super.initState();
    DateTime myDateTime = widget.array[widget.index]['createdAt'].toDate();
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

    print(widget.array[widget.index]['NumberOfComments']);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      List array = [];
                      var _doc1 = await FirebaseFirestore.instance
                          .collection("Users")
                          .doc(widget.array[widget.index]['AddedBy'])
                          .get();
                      bool docStatus1 = _doc1.exists;
                      if (docStatus1 == true) {
                        array.add(_doc1);
                        if (array[0]['Info']['Uid'] == UserDetails.uid) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserPage(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                array: array,
                                index: 0,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(196, 196, 196, 1),
                          image: DecorationImage(
                              image: NetworkImage(widget.array[widget.index]
                                  ['ProfilePhotoUrl']),
                              fit: BoxFit.cover),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(36, 36)),
                        )),
                  )
                ],
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.array[widget.index]['Name'],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Lato',
                            fontSize: 16,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                      SizedBox(width: 15),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(6, 6)),
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        widget.array[widget.index]['Username'],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 79, 90, 1),
                            fontFamily: 'Lato',
                            fontSize: 16,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        date,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Lato',
                            fontSize: 12,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                      SizedBox(width: 8),
                      Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(4, 4)),
                          )),
                      SizedBox(width: 8),

                      Text(
                        time,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Lato',
                            fontSize: 12,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                      // Icon(
                      //   Icons.wifi_tethering_outlined,
                      //   size: 14,
                      //   color: pink,
                      // ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: deviceWidth > 500 ? 395 : deviceWidth,
            height: 357,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoScreen(
                      url: widget.array[widget.index]['VideoUrl'],
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  Container(
                    width: deviceWidth > 500 ? 395 : deviceWidth,
                    height: 357,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: Color.fromRGBO(196, 196, 196, 1),
                      image: DecorationImage(
                          image: NetworkImage(
                              widget.array[widget.index]['ThumbnailImage']),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    width: deviceWidth > 500 ? 395 : deviceWidth,
                    height: 357,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: Color(0xFF000000).withOpacity(0.3),
                    ),
                  ),
                  Container(
                    width: deviceWidth > 500 ? 395 : deviceWidth,
                    height: 357,
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.play_circle_outline_outlined,
                        color: Colors.white,
                        size: 70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.array[widget.index]['VideoName'],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Lato',
                    fontSize: 16,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
              // Text(
              //   '$views Views',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //       color: Color.fromRGBO(0, 0, 0, 1),
              //       fontFamily: 'Lato',
              //       fontSize: 12,
              //       letterSpacing:
              //           0 /*percentages not used in flutter. defaulting to zero*/,
              //       fontWeight: FontWeight.normal,
              //       height: 1),
              // )
            ],
          ),
          SizedBox(height: 20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 118,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(9),
                      topRight: Radius.circular(9),
                      bottomLeft: Radius.circular(9),
                      bottomRight: Radius.circular(9),
                    ),
                    color: Color.fromRGBO(243, 243, 243, 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.thumb_up_alt_rounded,
                        size: 25,
                      ),
                      SizedBox(width: 3),
                      Text(
                        '375k',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Lato',
                            fontSize: 18,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 118,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(9),
                      topRight: Radius.circular(9),
                      bottomLeft: Radius.circular(9),
                      bottomRight: Radius.circular(9),
                    ),
                    color: Color.fromRGBO(243, 243, 243, 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.comment,
                        size: 25,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${widget.array[widget.index]['NumberOfComments']}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Lato',
                            fontSize: 18,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      )
                    ],
                  ),
                ),
                // Container(
                //   width: 118,
                //   height: 45,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(9),
                //       topRight: Radius.circular(9),
                //       bottomLeft: Radius.circular(9),
                //       bottomRight: Radius.circular(9),
                //     ),
                //     color: Color.fromRGBO(243, 243, 243, 1),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Icon(
                //         Icons.share,
                //         size: 25,
                //       ),
                //       SizedBox(width: 3),
                //       Text(
                //         '16k',
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //             color: Color.fromRGBO(0, 0, 0, 1),
                //             fontFamily: 'Lato',
                //             fontSize: 18,
                //             letterSpacing:
                //                 0 /*percentages not used in flutter. defaulting to zero*/,
                //             fontWeight: FontWeight.normal,
                //             height: 1),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
