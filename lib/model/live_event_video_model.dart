import 'package:flutter/material.dart';
import 'package:social_media/constants.dart';

class LiveEventVideo extends StatelessWidget {
  const LiveEventVideo(
      {Key? key,
      required this.user_name,
      required this.live_watching,
      required this.heading,
      required this.img,
      required this.user_dp})
      : super(key: key);

  final String user_name, live_watching, heading, img, user_dp;

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
                  Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(196, 196, 196, 1),
                        image: DecorationImage(
                            image: AssetImage(user_dp), fit: BoxFit.fitWidth),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(36, 36)),
                      ))
                ],
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        user_name,
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
                        'Follow',
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
                      Icon(
                        Icons.video_call,
                        size: 14,
                        color: pink,
                      ),
                      SizedBox(width: 3),
                      Text(
                        'Live',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: pink,
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
                        '$live_watching watching',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            fontFamily: 'Lato',
                            fontSize: 12,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                heading,
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
            ],
          ),
          SizedBox(height: 10),
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
              image:
                  DecorationImage(image: AssetImage(img), fit: BoxFit.fitWidth),
            ),
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
                      SizedBox(width: 3),
                      Text(
                        '50k',
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
                        Icons.share,
                        size: 25,
                      ),
                      SizedBox(width: 3),
                      Text(
                        '16k',
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
              ],
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
