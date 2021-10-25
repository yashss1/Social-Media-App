import 'package:flutter/material.dart';

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
            SingleChildScrollView(
              child: Column(
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
