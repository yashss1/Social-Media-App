import 'package:flutter/material.dart';

class TrendingVideo extends StatelessWidget {
  const TrendingVideo(
      {Key? key,
      required this.thumbnail,
      required this.profile_img,
      required this.video_name,
      required this.channel_name,
      required this.views,
      required this.time_uploaded,
      required this.duration})
      : super(key: key);

  final String thumbnail,
      profile_img,
      video_name,
      channel_name,
      views,
      time_uploaded,
      duration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 384,
          height: 178,
          child: Stack(
            children: [
              Container(
                width: 384,
                height: 178,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  color: Color.fromRGBO(196, 196, 196, 1),
                  image: DecorationImage(
                      image: AssetImage(thumbnail), fit: BoxFit.fitWidth),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.all(8),
                  width: 42,
                  height: 18,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(3),
                      topRight: Radius.circular(3),
                      bottomLeft: Radius.circular(3),
                      bottomRight: Radius.circular(3),
                    ),
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      duration,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Lato',
                          fontSize: 10,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 52,
                  height: 51,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(196, 196, 196, 1),
                    image: DecorationImage(
                        image: AssetImage(profile_img), fit: BoxFit.fitWidth),
                    borderRadius: BorderRadius.all(Radius.elliptical(52, 51)),
                  ),
                ),
              ],
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video_name,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Lato',
                      fontSize: 18,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      channel_name,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.47999998927116394),
                          fontFamily: 'Lato',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '$views views',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.47999998927116394),
                          fontFamily: 'Lato',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '$time_uploaded day ago',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.47999998927116394),
                          fontFamily: 'Lato',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 35),
      ],
    );
  }
}
