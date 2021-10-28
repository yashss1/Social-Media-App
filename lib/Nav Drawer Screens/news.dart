import 'package:flutter/material.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/model/category_news_model.dart';
import 'package:social_media/model/trending_news_model.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
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
                          'News',
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
                      children: [
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'Trending',
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
                                  ' News',
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
                            const Text(
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
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: const [
                              TrendingNews(
                                  heading:
                                      'Bank fail in bid to share cost of refunding scam victims',
                                  time: '8',
                                  img: 'assets/images/Rectangle30(1).png'),
                              TrendingNews(
                                  heading:
                                      'Yash made this UI perfect as expected',
                                  time: '15',
                                  img: 'assets/images/Rectangle30(1).png'),
                              TrendingNews(
                                  heading:
                                      'Bank fail in bid to share cost of refunding scam victims',
                                  time: '8',
                                  img: 'assets/images/Rectangle30(1).png'),
                            ],
                          ),
                        ),
                        SizedBox(height: 45),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sports',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: pink,
                                  fontFamily: 'Lato',
                                  fontSize: 20,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                            Text(
                              'Politics',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: black,
                                  fontFamily: 'Lato',
                                  fontSize: 20,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                            Text(
                              'Health',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: black,
                                  fontFamily: 'Lato',
                                  fontSize: 20,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                            Text(
                              'Business',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: black,
                                  fontFamily: 'Lato',
                                  fontSize: 20,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                            Text(
                              'Finance',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: black,
                                  fontFamily: 'Lato',
                                  fontSize: 20,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        const CategoryNews(
                            img: 'assets/images/Rectangle52.png',
                            name: 'Why esports game are booming in millenials',
                            cate: 'Esports',
                            min: '8'),
                        const CategoryNews(
                            img: 'assets/images/Rectangle53.png',
                            name:
                                'Do Yash need one more victory to make a record in oval? ',
                            cate: 'Cricket',
                            min: '15'),
                        const CategoryNews(
                            img: 'assets/images/Rectangle54.png',
                            name:
                                'Field and race format will confirmed for new F1 season',
                            cate: 'Esports',
                            min: '20'),
                        const CategoryNews(
                            img: 'assets/images/Rectangle52.png',
                            name: 'Why esports game are booming in millenials',
                            cate: 'Esports',
                            min: '56'),
                        const CategoryNews(
                            img: 'assets/images/Rectangle53.png',
                            name:
                                'Do Yash need one more victory to make a record in oval? ',
                            cate: 'Cricket',
                            min: '15'),
                        const CategoryNews(
                            img: 'assets/images/Rectangle54.png',
                            name:
                                'Field and race format will confirmed for new F1 season',
                            cate: 'Esports',
                            min: '20'),
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
