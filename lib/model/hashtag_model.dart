import 'package:flutter/material.dart';

class HashTagModel extends StatelessWidget {
  const HashTagModel(
      {Key? key, required this.num, required this.name, required this.people})
      : super(key: key);

  final String num, name, people;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: deviceWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$num.',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Lato',
                    fontSize: 18,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )
            ],
          ),
          SizedBox(width: 35),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#$name',
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
              SizedBox(height: 5),
              Text(
                '$people people used',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.6000000238418579),
                    fontFamily: 'Lato',
                    fontSize: 14,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
              SizedBox(height: 25),
            ],
          ),
        ],
      ),
    );
  }
}
