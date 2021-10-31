import 'package:flutter/material.dart';

class PopularStreamersModel extends StatelessWidget {
  const PopularStreamersModel(
      {Key? key,
      required this.name,
      required this.followers,
      required this.img})
      : super(key: key);

  final String name, followers, img;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      width: deviceWidth,
      height: 71,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.07000000029802322),
              offset: Offset(2, 2),
              blurRadius: 50)
        ],
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Row(
        children: [
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 49,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14),
                  ),
                  color: Color.fromRGBO(196, 196, 196, 1),
                  image: DecorationImage(
                      image: AssetImage(img), fit: BoxFit.fitWidth),
                ),
              ),
            ],
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    name,
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
                  SizedBox(width: 5),
                  Icon(
                    Icons.verified_sharp,
                    color: Color(0xffFFC107),
                    size: 20,
                  ),
                ],
              ),
              SizedBox(height: 7),
              Text(
                '$followers Followers',
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
            ],
          ),
        ],
      ),
    );
  }
}
