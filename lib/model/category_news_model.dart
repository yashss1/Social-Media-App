import 'package:flutter/material.dart';
import 'package:social_media/constants.dart';

class CategoryNews extends StatelessWidget {
  const CategoryNews(
      {Key? key,
      required this.img,
      required this.name,
      required this.cate,
      required this.min})
      : super(key: key);

  final String img, name, cate, min;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 99,
                height: 87,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(196, 196, 196, 1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                      image: AssetImage(img), fit: BoxFit.fitHeight),
                ),
              ),
            ],
          ),
          SizedBox(width: 17),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: deviceWidth - 150,
                child: Text(
                  name,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Lato',
                      fontSize: 18,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: deviceWidth * .4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cate,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: pink,
                          fontFamily: 'Lato',
                          fontSize: 16,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.6100000143051147),
                        borderRadius: BorderRadius.all(Radius.elliptical(7, 7)),
                      ),
                    ),
                    Text(
                      '$min min ago',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.6100000143051147),
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
            ],
          ),
        ],
      ),
    );
  }
}
