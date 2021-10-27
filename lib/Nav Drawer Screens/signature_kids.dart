import 'package:flutter/material.dart';
import 'package:social_media/model/my_library_model.dart';

class SignatureKids extends StatefulWidget {
  const SignatureKids({Key? key}) : super(key: key);

  @override
  _SignatureKidsState createState() => _SignatureKidsState();
}

class _SignatureKidsState extends State<SignatureKids> {
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
                    const Text(
                      'Signature for Kids',
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
                                  image: AssetImage(
                                      'assets/images/Ellipse13(1).png'),
                                  fit: BoxFit.fitHeight),
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
                    physics: BouncingScrollPhysics(),
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
                                          'assets/images/Rectangle10.png'),
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
                                                  'assets/images/Ellipse13(1).png'),
                                              fit: BoxFit.fitHeight),
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
                          'Jean Johnson Jr.',
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
                        SizedBox(height: 55),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'My Library',
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
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: const [
                                  LibModel(
                                      img: 'assets/images/Rectangle26.png'),
                                  SizedBox(height: 15),
                                  LibModel(
                                      img: 'assets/images/Rectangle30.png'),
                                  SizedBox(height: 15),
                                  LibModel(
                                      img: 'assets/images/Rectangle34.png'),
                                  SizedBox(height: 15),
                                ],
                              ),
                              SizedBox(width: 20),
                              Column(
                                children: const [
                                  LibModel(
                                      img: 'assets/images/Rectangle27.png'),
                                  SizedBox(height: 15),
                                  LibModel(
                                      img: 'assets/images/Rectangle31.png'),
                                  SizedBox(height: 15),
                                  LibModel(
                                      img: 'assets/images/Rectangle35.png'),
                                  SizedBox(height: 15),
                                ],
                              ),
                              SizedBox(width: 20),
                              Column(
                                children: const [
                                  LibModel(
                                      img: 'assets/images/Rectangle28.png'),
                                  SizedBox(height: 15),
                                  LibModel(
                                      img: 'assets/images/Rectangle32.png'),
                                  SizedBox(height: 15),
                                  LibModel(
                                      img: 'assets/images/Rectangle36.png'),
                                  SizedBox(height: 15),
                                ],
                              ),
                              SizedBox(width: 20),
                              Column(
                                children: const [
                                  LibModel(
                                      img: 'assets/images/Rectangle29.png'),
                                  SizedBox(height: 15),
                                  LibModel(
                                      img: 'assets/images/Rectangle33.png'),
                                  SizedBox(height: 15),
                                  LibModel(
                                      img: 'assets/images/Rectangle37.png'),
                                  SizedBox(height: 20),
                                ],
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
