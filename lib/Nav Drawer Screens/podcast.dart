import 'package:flutter/material.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/model/episode_model.dart';
import 'package:social_media/model/popular_host_model.dart';

class PodCast extends StatefulWidget {
  const PodCast({Key? key}) : super(key: key);

  @override
  _PodCastState createState() => _PodCastState();
}

class _PodCastState extends State<PodCast> {
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
                          'Podcast',
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
                  width: deviceWidth,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 25),
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
                              ' Hosts',
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
                        SizedBox(height: 20),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: const [
                              PopularHost(
                                  name: 'Udit Petot',
                                  img: 'assets/images/Rectangle34(1).png',
                                  posts: '310'),
                              SizedBox(width: 12),
                              PopularHost(
                                  name: 'Agum Bucid',
                                  img: 'assets/images/Rectangle35(1).png',
                                  posts: '347'),
                              SizedBox(width: 12),
                              PopularHost(
                                  name: 'Udit Petot',
                                  img: 'assets/images/Rectangle36(1).png',
                                  posts: '110'),
                              SizedBox(width: 12),
                              PopularHost(
                                  name: 'Udit Petot',
                                  img: 'assets/images/Rectangle37(1).png',
                                  posts: '297'),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
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
                              ' Episode',
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
                        const SizedBox(height: 25),
                        const TopEpisode(
                            img: 'assets/images/Rectangle30 (1).png',
                            name: 'Product Design',
                            ep: '15',
                            min: '153'),
                        const TopEpisode(
                            img: 'assets/images/Rectangle31(1).png',
                            name: 'Business Strategy',
                            ep: '17',
                            min: '152'),
                        const TopEpisode(
                            img: 'assets/images/Rectangle32(1).png',
                            name: 'Self Improvement',
                            ep: '11',
                            min: '452'),
                        const TopEpisode(
                            img: 'assets/images/Rectangle33(1).png',
                            name: 'Digital Marketing',
                            ep: '12',
                            min: '200'),
                        const TopEpisode(
                            img: 'assets/images/Rectangle30 (1).png',
                            name: 'Product Design',
                            ep: '15',
                            min: '153'),
                        const TopEpisode(
                            img: 'assets/images/Rectangle31(1).png',
                            name: 'Business Strategy',
                            ep: '17',
                            min: '152'),
                        const TopEpisode(
                            img: 'assets/images/Rectangle32(1).png',
                            name: 'Self Improvement',
                            ep: '11',
                            min: '452'),
                        const TopEpisode(
                            img: 'assets/images/Rectangle33(1).png',
                            name: 'Digital Marketing',
                            ep: '12',
                            min: '200'),
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
