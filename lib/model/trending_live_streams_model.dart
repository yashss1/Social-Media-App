import 'package:flutter/material.dart';

class TrendingLiveStreams extends StatelessWidget {
  const TrendingLiveStreams(
      {Key? key,
      required this.thumbnail,
      required this.views,
      required this.user,
      required this.video_name,
      required this.user_dp})
      : super(key: key);

  final String thumbnail, views, user, video_name, user_dp;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      width: 310,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.07000000029802322),
              offset: Offset(2, 2),
              blurRadius: 47)
        ],
        color: Color.fromRGBO(255, 255, 255, 1),
        border: Border.all(
          color: Color.fromRGBO(0, 0, 0, 1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          Container(
            width: 280,
            height: 157,
            child: Stack(
              children: [
                Container(
                  width: 280,
                  height: 157,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    image: DecorationImage(
                        image: AssetImage(thumbnail), fit: BoxFit.fitWidth),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, bottom: 10),
                    width: 90,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      color: Color.fromRGBO(255, 79, 90, 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 2),
                        Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: 50,
                          child: Text(
                            views,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'Lato',
                                fontSize: 16,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 49,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: Color.fromRGBO(196, 196, 196, 1),
                        image: DecorationImage(
                            image: AssetImage(user_dp), fit: BoxFit.fitWidth),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          user,
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
                        SizedBox(width: 5),
                        Icon(
                          Icons.verified_sharp,
                          color: Color(0xffFFC107),
                          size: 20,
                        ),
                      ],
                    ),
                    Container(
                      width: 220,
                      child: Text(
                        video_name,
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
