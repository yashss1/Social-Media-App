import 'package:flutter/material.dart';

class FriendModel extends StatelessWidget {
  const FriendModel({Key? key, required this.name, required this.img}) : super(key: key);

  final String name, img;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 90,
            height: 93,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Color.fromRGBO(196, 196, 196, 1),
              image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.fitWidth),
            )),
        Text(
          name,
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1.0),
              fontFamily: 'Lato',
              fontSize: 18,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
      ],
    );
  }
}
