import 'package:flutter/material.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/model/shop_category_model.dart';
import 'package:social_media/model/shop_picked_model.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
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
                          'Shop',
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
                  width: deviceWidth,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        const Text(
                          'Today Pick’s',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Lato',
                              fontSize: 20,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: const [
                              ShopPicked(
                                  img: 'assets/images/Rectangle89.png',
                                  name: 'Watch',
                                  price: '100'),
                              ShopPicked(
                                  img: 'assets/images/Rectangle90.png',
                                  name: 'Shirt',
                                  price: '150'),
                              ShopPicked(
                                  img: 'assets/images/Rectangle89.png',
                                  name: 'Watch',
                                  price: '100'),
                              ShopPicked(
                                  img: 'assets/images/Rectangle90.png',
                                  name: 'Shirt',
                                  price: '150'),
                            ],
                          ),
                        ),
                        SizedBox(height: 45),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Watch',
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
                              'Shirt',
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
                              'Jeans',
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
                              'Earphones',
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
                              'Mobiles',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            ShopCategory(
                                img: 'assets/images/Rectangle91.png',
                                name: 'Dura Watch',
                                price: '24'),
                            ShopCategory(
                                img: 'assets/images/Rectangle92.png',
                                name: 'Rolex Watch',
                                price: '49'),
                            ShopCategory(
                                img: 'assets/images/Rectangle93.png',
                                name: 'Titan Watch',
                                price: '26'),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            ShopCategory(
                                img: 'assets/images/Rectangle94.png',
                                name: 'Dura Watch',
                                price: '24'),
                            ShopCategory(
                                img: 'assets/images/Rectangle95.png',
                                name: 'Rolex Watch',
                                price: '49'),
                            ShopCategory(
                                img: 'assets/images/Rectangle96.png',
                                name: 'Titan Watch',
                                price: '26'),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            ShopCategory(
                                img: 'assets/images/Rectangle91.png',
                                name: 'Dura Watch',
                                price: '24'),
                            ShopCategory(
                                img: 'assets/images/Rectangle92.png',
                                name: 'Rolex Watch',
                                price: '49'),
                            ShopCategory(
                                img: 'assets/images/Rectangle93.png',
                                name: 'Yash Watch',
                                price: '26'),
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
