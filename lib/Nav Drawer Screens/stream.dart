import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/model/popular_streamers_model.dart';
import 'package:social_media/model/top_games_model.dart';
import 'package:social_media/model/trending_live_streams_model.dart';

class Stream extends StatefulWidget {
  const Stream({Key? key}) : super(key: key);

  @override
  _StreamState createState() => _StreamState();
}

class _StreamState extends State<Stream> {
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
                          'Stream',
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
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Container(
                          width: deviceWidth,
                          height: 46,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            color: Color.fromRGBO(
                                226, 226, 226, 0.3199999928474426),
                            border: Border.all(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: deviceWidth - 100,
                                child: TextField(
                                  textAlign: TextAlign.start,
                                  onChanged: (value) {
                                    //Do something with the user input.
                                  },
                                  decoration:
                                      kMessageTextFieldDecoration.copyWith(
                                    hintText: "Search your Favourite Streamers",
                                  ),
                                ),
                              ),
                              Container(
                                width: 43,
                                height: 46,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(
                                            0, 0, 0, 0.14000000059604645),
                                        offset: Offset(1, 1),
                                        blurRadius: 12)
                                  ],
                                  color: Color.fromRGBO(255, 79, 90, 1),
                                ),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Top',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Lato',
                                  fontSize: 22,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.bold,
                                  height: 1),
                            ),
                            Text(
                              ' Games',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Lato',
                                  fontSize: 22,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ],
                        ),
                        SizedBox(height: 18),
                        Container(
                          width: deviceWidth,
                          color: white,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                TopGamesModel(
                                    name: 'PUBG MOBILE',
                                    img: 'assets/images/Rectangle61.png'),
                                TopGamesModel(
                                    name: 'FREE FIRE',
                                    img: 'assets/images/Rectangle63.png'),
                                TopGamesModel(
                                    name: 'COD',
                                    img: 'assets/images/Rectangle65.png'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Trending Live Streams',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Lato',
                                  fontSize: 22,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.bold,
                                  height: 1),
                            ),
                            Text(
                              'Show all',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(
                                      255, 79, 90, 0.7900000214576721),
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ],
                        ),
                        SizedBox(height: 18),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              TrendingLiveStreams(
                                  thumbnail: 'assets/images/Rectangle67.png',
                                  views: '80.9K',
                                  user: 'InstaGamer',
                                  video_name: 'Georgopol Survival Challenge',
                                  user_dp: 'assets/images/Rectangle69.png'),
                              TrendingLiveStreams(
                                  thumbnail: 'assets/images/Rectangle71.png',
                                  views: '79.4K',
                                  user: 'YashGamer',
                                  video_name: 'Heist Survival Challenge',
                                  user_dp: 'assets/images/Rectangle73.png'),
                              TrendingLiveStreams(
                                  thumbnail: 'assets/images/Rectangle67.png',
                                  views: '80.9K',
                                  user: 'InstaGamer',
                                  video_name: 'Georgopol Survival Challenge',
                                  user_dp: 'assets/images/Rectangle69.png'),
                            ],
                          ),
                        ),
                        SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Popular Streamers',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Lato',
                                  fontSize: 22,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.bold,
                                  height: 1),
                            ),
                            Text(
                              'Show all',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(
                                      255, 79, 90, 0.7900000214576721),
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ],
                        ),
                        SizedBox(height: 18),
                        Column(
                          children: [
                            PopularStreamersModel(
                                name: 'LiveStreamer',
                                followers: '5.1M',
                                img: 'assets/images/Rectangle75.png'),
                            PopularStreamersModel(
                                name: 'Xfinity',
                                followers: '121K',
                                img: 'assets/images/Rectangle77.png'),
                            PopularStreamersModel(
                                name: 'LiveStreamer',
                                followers: '5.1M',
                                img: 'assets/images/Rectangle75.png'),
                            PopularStreamersModel(
                                name: 'Xfinity',
                                followers: '121K',
                                img: 'assets/images/Rectangle77.png'),
                          ],
                        ),
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
