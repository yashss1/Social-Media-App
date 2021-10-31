import 'package:flutter/material.dart';

class MusicModel extends StatelessWidget {
  const MusicModel(
      {Key? key,
      required this.img,
      required this.album_name,
      required this.singer})
      : super(key: key);

  final String img, album_name, singer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Container(
            width: 118,
            height: 119,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Color.fromRGBO(196, 196, 196, 1),
              image: DecorationImage(
                  image: AssetImage(img), fit: BoxFit.fitHeight),
            ),
          ),
          SizedBox(height: 13),
          Text(
            album_name,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Lato',
                fontSize: 16,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
          SizedBox(height: 5),
          Text(
            "by $singer",
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                fontFamily: 'Lato',
                fontSize: 12,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
