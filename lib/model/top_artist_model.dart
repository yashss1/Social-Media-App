import 'package:flutter/material.dart';

class TopArtist extends StatelessWidget {
  const TopArtist({Key? key, required this.name, required this.img})
      : super(key: key);

  final String name, img;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 67,
            height: 61,
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
          SizedBox(height: 5),
          Text(
            name,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Lato',
                fontSize: 11,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ],
      ),
    );
  }
}
