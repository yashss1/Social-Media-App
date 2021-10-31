import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/model/music_model.dart';
import 'package:social_media/model/top_artist_model.dart';

class Music extends StatefulWidget {
  const Music({Key? key}) : super(key: key);

  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
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
                          'Music',
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
                      children: [
                        SizedBox(height: 30),
                        Container(
                          width: 384,
                          height: 155,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Color.fromRGBO(196, 196, 196, 1),
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/Rectangle89(1).png'),
                                fit: BoxFit.fitWidth),
                          ),
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Top Songs',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Lato',
                                  fontSize: 16,
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
                            )
                          ],
                        ),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: const [
                              MusicModel(
                                  img: 'assets/images/Rectangle91 (1).png',
                                  album_name: 'See you again',
                                  singer: 'Wiz Khalifa'),
                              MusicModel(
                                  img: 'assets/images/Rectangle92(1).png',
                                  album_name: 'Sorry',
                                  singer: 'Justin Bieber'),
                              MusicModel(
                                  img: 'assets/images/Rectangle93(1).png',
                                  album_name: 'Uptown Funk',
                                  singer: 'Mark Ronson'),
                              MusicModel(
                                  img: 'assets/images/Rectangle91 (1).png',
                                  album_name: 'See you again',
                                  singer: 'Wiz Khalifa'),
                              MusicModel(
                                  img: 'assets/images/Rectangle92(1).png',
                                  album_name: 'Sorry',
                                  singer: 'Justin Bieber'),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'You might also like ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Lato',
                                  fontSize: 16,
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
                            )
                          ],
                        ),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: const [
                              MusicModel(
                                  img: 'assets/images/Rectangle94(1).png',
                                  album_name: 'Blank Space',
                                  singer: 'Taylor Swift'),
                              MusicModel(
                                  img: 'assets/images/Rectangle95(1).png',
                                  album_name: 'Shake It Off',
                                  singer: 'Taylor Swift'),
                              MusicModel(
                                  img: 'assets/images/Rectangle96(1).png',
                                  album_name: 'Lean On',
                                  singer: 'Major Lazer'),
                              MusicModel(
                                  img: 'assets/images/Rectangle94(1).png',
                                  album_name: 'Blank Space',
                                  singer: 'Taylor Swift'),
                              MusicModel(
                                  img: 'assets/images/Rectangle95(1).png',
                                  album_name: 'Shake It Off',
                                  singer: 'Taylor Swift'),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Top Artists',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Lato',
                                  fontSize: 16,
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
                        SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            children: const [
                              TopArtist(
                                  name: 'Wiz Khalifa',
                                  img: 'assets/images/Rectangle97.png'),
                              TopArtist(
                                  name: 'Justin Bieber',
                                  img: 'assets/images/Rectangle98.png'),
                              TopArtist(
                                  name: 'Mark Ronson',
                                  img: 'assets/images/Rectangle99.png'),
                              TopArtist(
                                  name: 'Taylor Swift',
                                  img: 'assets/images/Rectangle100.png'),
                              TopArtist(
                                  name: 'Dj Shake',
                                  img: 'assets/images/Rectangle101.png'),
                              TopArtist(
                                  name: 'Wiz Khalifa',
                                  img: 'assets/images/Rectangle97.png'),
                              TopArtist(
                                  name: 'Justin Bieber',
                                  img: 'assets/images/Rectangle98.png'),
                              TopArtist(
                                  name: 'Mark Ronson',
                                  img: 'assets/images/Rectangle99.png'),
                              TopArtist(
                                  name: 'Taylor Swift',
                                  img: 'assets/images/Rectangle100.png'),
                              TopArtist(
                                  name: 'Dj Shake',
                                  img: 'assets/images/Rectangle101.png'),
                            ],
                          ),
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
