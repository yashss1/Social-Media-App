import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/model/friends_model.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      splashColor: Colors.pink,
                      onTap: () {},
                      child: const Icon(
                        Icons.arrow_back,
                        size: 28,
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth * .30,
                    ),
                    const Text(
                      'Signature',
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
              ),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: deviceHeight * 0.30,
                          width: deviceWidth,
                          child: Stack(
                            children: [
                              Container(
                                width: deviceWidth,
                                height: deviceHeight * 0.25,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(196, 196, 196, 1),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/Rectangle10 (1).png'),
                                      fit: BoxFit.fitWidth),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 125,
                                        height: 122,
                                        decoration: const BoxDecoration(
                                          color:
                                              Color.fromRGBO(196, 196, 196, 1),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/Ellipse13.png'),
                                              fit: BoxFit.fitWidth),
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(125, 122)),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: -15,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              right: 16, bottom: 10),
                                          width: 35,
                                          height: 35,
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                                Radius.elliptical(125, 122)),
                                          ),
                                          child: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin:
                                      EdgeInsets.only(right: 16, bottom: 60),
                                  width: 35,
                                  height: 35,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(125, 122)),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        const Text(
                          'Jean Johnson',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Lato',
                              fontSize: 20,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.bold,
                              height: 1),
                        ),
                        SizedBox(height: 15),
                        const Text(
                          'Husband, Father, Hard Worker',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Lato',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 151,
                          height: 46,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            border: Border.all(
                              color: const Color.fromRGBO(0, 0, 0, 1),
                              width: 1,
                            ),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Edit your profile',
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
                        ),
                        SizedBox(height: 35),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Text(
                                        'Work at:',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            letterSpacing:
                                                0 /*percentages not used in flutter. defaulting to zero*/,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Youtuber',
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
                                  Row(
                                    children: const [
                                      Text(
                                        'Birthday :',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            letterSpacing:
                                                0 /*percentages not used in flutter. defaulting to zero*/,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '08 / January / 1990',
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
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Text(
                                        'Followed By :',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            letterSpacing:
                                                0 /*percentages not used in flutter. defaulting to zero*/,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '533 People',
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
                                  Row(
                                    children: const [
                                      Text(
                                        'Live in :',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            letterSpacing:
                                                0 /*percentages not used in flutter. defaulting to zero*/,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'California USA',
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
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Friends',
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
                                    'See All',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(
                                            0, 0, 0, 0.41999998688697815),
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
                              const Text(
                                '854 friends',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(
                                        0, 0, 0, 0.6299999952316284),
                                    fontFamily: 'Lato',
                                    fontSize: 14,
                                    letterSpacing:
                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                              SizedBox(height: 30),
                              SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: const [
                                    FriendModel(
                                        name: 'Alex John',
                                        img: 'assets/images/Rectangle12.png'),
                                    SizedBox(width: 20),
                                    FriendModel(
                                        name: 'Martin',
                                        img: 'assets/images/Rectangle13.png'),
                                    SizedBox(width: 20),
                                    FriendModel(
                                        name: 'Shreya Roy',
                                        img: 'assets/images/Rectangle14.png'),
                                    SizedBox(width: 20),
                                    FriendModel(
                                        name: 'Mila John',
                                        img: 'assets/images/Rectangle15.png'),
                                    SizedBox(width: 20),
                                  ],
                                ),
                              ),
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
