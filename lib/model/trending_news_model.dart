import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/constants.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews(
      {Key? key, required this.heading, required this.time, required this.img})
      : super(key: key);

  final String heading, time, img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Container(
            width: 251,
            height: 145,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15000000596046448),
                    offset: Offset(5, 1),
                    blurRadius: 37)
              ],
              color: Color.fromRGBO(196, 196, 196, 1),
              image:
                  DecorationImage(image: AssetImage(img), fit: BoxFit.fitWidth),
            ),
          ),
          SizedBox(height: 12),
          Container(
            width: 251,
            child: Text(
              heading,
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
          SizedBox(height: 12),
          Container(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Business',
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
                  '$time min ago',
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
    );
  }
}
