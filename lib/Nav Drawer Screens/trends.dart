import 'package:flutter/material.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/model/trend_video.dart';

class Trends extends StatefulWidget {
  const Trends({Key? key}) : super(key: key);

  @override
  _TrendsState createState() => _TrendsState();
}

class _TrendsState extends State<Trends> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: deviceWidth,
          height: deviceHeight,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: deviceWidth,
                height: 70,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          splashColor: Colors.pink,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            size: 28,
                          ),
                        ),
                        SizedBox(width: 25),
                        const Text(
                          'Trends',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 79, 90, 1),
                              fontFamily: 'Lato',
                              fontSize: 20,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.search,
                          size: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 5,
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                width: deviceWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Now',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: pink,
                          fontFamily: 'Lato',
                          fontSize: 16,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    const Text(
                      'Music',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lato',
                          fontSize: 16,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    const Text(
                      'Gaming',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lato',
                          fontSize: 16,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    const Text(
                      'Movies',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Lato',
                          fontSize: 16,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 5,
                color: Colors.grey,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(height: 25),
                        TrendingVideo(
                            thumbnail: 'assets/images/Rectangle111.png',
                            profile_img: 'assets/images/Ellipse134.png',
                            video_name: 'My Sister Vs Cousin Sister',
                            channel_name: 'Yash Sonawane Vlog',
                            views: '3M',
                            time_uploaded: '3',
                            duration: '12:00'),
                        TrendingVideo(
                            thumbnail: 'assets/images/Rectangle10.png',
                            profile_img: 'assets/images/Ellipse137.png',
                            video_name: 'My Sister and Me Playing',
                            channel_name: 'Sam Harry Vlog',
                            views: '815K',
                            time_uploaded: '2',
                            duration: '2:45'),
                        TrendingVideo(
                            thumbnail: 'assets/images/Rectangle17.png',
                            profile_img: 'assets/images/Ellipse140.png',
                            video_name: 'How Plane Flies?',
                            channel_name: 'Rishav Vlog',
                            views: '20K',
                            time_uploaded: '3',
                            duration: '15:00'),
                        TrendingVideo(
                            thumbnail: 'assets/images/Rectangle16.png',
                            profile_img: 'assets/images/Rectangle34(1).png',
                            video_name: 'Biker Vs Bike',
                            channel_name: 'Sam Jain Vlog',
                            views: '45K',
                            time_uploaded: '6',
                            duration: '21:00'),
                        TrendingVideo(
                            thumbnail: 'assets/images/Rectangle111.png',
                            profile_img: 'assets/images/Rectangle35(1).png',
                            video_name: 'My Sister Vs Cousin Sister',
                            channel_name: 'Yash Sonawane Vlog',
                            views: '42',
                            time_uploaded: '8',
                            duration: '9:48'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
