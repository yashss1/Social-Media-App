import 'package:flutter/material.dart';

class NewestGames extends StatelessWidget {
  const NewestGames({Key? key, required this.img, required this.name, required this.cate}) : super(key: key);

  final String img, name, cate;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 89,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Color.fromRGBO(196, 196, 196, 1),
                  image: DecorationImage(
                      image: AssetImage(img),
                      fit: BoxFit.fitHeight),
                ),
              ),
            ],
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Lato',
                    fontSize: 18,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
              SizedBox(height: 8),
              Text(
                cate,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.4000000059604645),
                    fontFamily: 'Lato',
                    fontSize: 16,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
              SizedBox(height: 2),
              Container(
                width: 140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.star,
                      color: Color(0xffFFC107),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffFFC107),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffFFC107),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffFFC107),
                    ),
                    Icon(
                      Icons.star_border,
                      color: Color(0xffFFC107),
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
