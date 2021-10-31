import 'package:flutter/material.dart';

class TopGamesModel extends StatelessWidget {
  const TopGamesModel({Key? key, required this.name, required this.img})
      : super(key: key);

  final String name, img;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      width: 170,
      height: 61,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
              offset: Offset(2, 2),
              blurRadius: 50)
        ],
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 45,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              image:
                  DecorationImage(image: AssetImage(img), fit: BoxFit.fitWidth),
            ),
          ),
          Text(
            name,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Lato',
                fontSize: 14,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1),
          )
        ],
      ),
    );
  }
}
