import 'package:flutter/material.dart';

class PopularGames extends StatelessWidget {
  const PopularGames({Key? key, required this.img}) : super(key: key);

  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      width: 251,
      height: 145,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15000000596046448),
              offset: Offset(3, -1),
              blurRadius: 14)
        ],
        color: Color.fromRGBO(196, 196, 196, 1),
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.fitWidth),
      ),
    );
  }
}
