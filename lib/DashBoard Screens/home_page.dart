import 'package:flutter/material.dart';
import 'package:social_media/model/story_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                  InkWell(
                    splashColor: Colors.pink,
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: const Icon(
                      Icons.notes,
                      size: 28,
                    ),
                  ),
                  const Text(
                    'Signature',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 79, 90, 1),
                        fontFamily: 'Lato',
                        fontSize: 23,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.notifications_none,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Container(
                          width: 34.14285659790039,
                          height: 32.590911865234375,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(196, 196, 196, 1),
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/Ellipse13.png'),
                                fit: BoxFit.fitWidth),
                            borderRadius: BorderRadius.all(Radius.elliptical(
                                34.14285659790039, 32.590911865234375)),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: const [
                            Story1(
                                stry: 'assets/images/Rectangle16.png',
                                img: 'assets/images/Rectangle12.png'),
                            Story1(
                                stry: 'assets/images/Rectangle17.png',
                                img: 'assets/images/Rectangle13.png'),
                            Story1(
                                stry: 'assets/images/Rectangle18.png',
                                img: 'assets/images/Rectangle14.png'),
                            Story1(
                                stry: 'assets/images/Rectangle19.png',
                                img: 'assets/images/Rectangle15.png'),
                            Story1(
                                stry: 'assets/images/Rectangle20.png',
                                img: 'assets/images/Rectangle14.png'),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        width: deviceWidth,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          border: Border.all(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(
                                        left: 20,
                                        right: 50,
                                        top: 15,
                                        bottom: 15),
                                    width: 52,
                                    height: 52,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(100, 94, 94, 1),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/Ellipse13.png'),
                                          fit: BoxFit.fitWidth),
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(52, 52)),
                                    )),
                                const Text(
                                  'Something new in your mind',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(
                                          0, 0, 0, 0.4699999988079071),
                                      fontFamily: 'Lato',
                                      fontSize: 16,
                                      letterSpacing:
                                          0 /*percentages not used in flutter. defaulting to zero*/,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                )
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  '😃',
                                  style: TextStyle(fontSize: 25),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '😍',
                                  style: TextStyle(fontSize: 25),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '😡',
                                  style: TextStyle(fontSize: 25),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '👍',
                                  style: TextStyle(fontSize: 25),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '👎',
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 107,
                              height: 40,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  topRight: Radius.circular(6),
                                  bottomLeft: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                ),
                                color: Color.fromRGBO(
                                    255, 79, 90, 0.800000011920929),
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Publish',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontFamily: 'Lato',
                                      fontSize: 20,
                                      letterSpacing:
                                          0 /*percentages not used in flutter. defaulting to zero*/,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                ),
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
    );
  }
}
