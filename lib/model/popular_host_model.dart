import 'package:flutter/material.dart';

class PopularHost extends StatelessWidget {
  const PopularHost(
      {Key? key, required this.name, required this.img, required this.posts})
      : super(key: key);

  final String name, img, posts;

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
              image:
                  DecorationImage(image: AssetImage(img), fit: BoxFit.fitWidth),
            )),
        SizedBox(height: 5),
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
        const SizedBox(height: 8),
        Text(
          '$posts posts',
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
    );
  }
}
