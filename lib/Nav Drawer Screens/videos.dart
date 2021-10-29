import 'package:flutter/material.dart';
import 'package:social_media/model/video_model.dart';

class Videos extends StatefulWidget {
  const Videos({Key? key}) : super(key: key);

  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
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
                          'Videos',
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
                        VideoModel(
                            user_name: 'Justin Flom',
                            views: '111M',
                            caption: 'It spilled Everywhere',
                            img: 'assets/images/Rectangle91(1).png',
                            user_dp: 'assets/images/Ellipse111.png',
                            date: 'Aug 1'),
                        VideoModel(
                            user_name: 'Yash Sonawane',
                            views: '521M',
                            caption: 'You should Study Always',
                            img: 'assets/images/Rectangle105.png',
                            user_dp: 'assets/images/Rectangle36(1).png',
                            date: 'Jan 8'),
                        VideoModel(
                            user_name: 'Maria Chan',
                            views: '123K',
                            caption: 'What should I write here',
                            img: 'assets/images/Rectangle91(1).png',
                            user_dp: 'assets/images/Ellipse129.png',
                            date: 'Aug 10'),
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
