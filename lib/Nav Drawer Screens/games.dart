import 'package:flutter/material.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/model/newest_games_model.dart';
import 'package:social_media/model/popular_games_model.dart';

class Games extends StatefulWidget {
  const Games({Key? key}) : super(key: key);

  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
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
                          'Games',
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
                                    hintText: "Search your Favourite Game",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'Popular',
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
                        SizedBox(height: 15),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              PopularGames(
                                  img: 'assets/images/Rectangle30 (2).png'),
                              PopularGames(
                                  img: 'assets/images/Rectangle48.png'),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Newest Games',
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
                        Column(
                          children: [
                            NewestGames(
                                img: 'assets/images/Rectangle52.png',
                                name: 'Ori and The Blind Forest',
                                cate: 'Adventure'),
                            NewestGames(
                                img: 'assets/images/Rectangle56.png',
                                name: 'COD : Call of Duty',
                                cate: 'Adventure, Action'),
                            NewestGames(
                                img: 'assets/images/Rectangle57.png',
                                name: 'GTA ys',
                                cate: 'Action, Drama'),
                            NewestGames(
                                img: 'assets/images/Rectangle52.png',
                                name: 'Ori and The Blind Forest',
                                cate: 'Adventure'),
                            NewestGames(
                                img: 'assets/images/Rectangle56.png',
                                name: 'COD : Call of Duty',
                                cate: 'Adventure, Action'),
                            NewestGames(
                                img: 'assets/images/Rectangle57.png',
                                name: 'GTA ys',
                                cate: 'Action, Drama'),
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
