import 'package:flutter/material.dart';

class CommentModel extends StatelessWidget {
  const CommentModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(100, 94, 94, 1),
                  image: DecorationImage(
                      image: AssetImage('assets/images/Rectangle12.png'),
                      fit: BoxFit.fitWidth),
                  borderRadius: BorderRadius.all(Radius.elliptical(36, 36)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Danny Gloves',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Lato',
                    fontSize: 17,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
              SizedBox(height: 5),
               Text(
                '@dannygloves',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.8100000023841858),
                    fontFamily: 'Lato',
                    fontSize: 15,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
              SizedBox(height: 10),
              const Text(
                'I’ve been working hard last days, that now i feel like i\nreally need a break! sleepless nights and restless days,\n oh my gush, am i insane or so ?',
                textAlign: TextAlign.left,
                maxLines: 5,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.949999988079071),
                    fontFamily: 'Lato',
                    fontSize: 15,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
              SizedBox(height: 10),
              Container(
                width: deviceWidth * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Text(
                          '👍',
                          style: TextStyle(fontSize: 19),
                        ),
                        SizedBox(width: 2),
                        Text(
                          '86',
                          textAlign: TextAlign.left,
                          style: TextStyle(
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
                    Row(
                      children: const [
                        Text(
                          '👎',
                          style: TextStyle(fontSize: 19),
                        ),
                        SizedBox(width: 2),
                        Text(
                          '12',
                          textAlign: TextAlign.left,
                          style: TextStyle(
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
                    Row(
                      children: const [
                        Text(
                          '😃',
                          style: TextStyle(fontSize: 19),
                        ),
                        SizedBox(width: 2),
                        Text(
                          '55',
                          textAlign: TextAlign.left,
                          style: TextStyle(
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
                    Row(
                      children: const [
                        Text(
                          '😍',
                          style: TextStyle(fontSize: 19),
                        ),
                        SizedBox(width: 2),
                        Text(
                          '19',
                          textAlign: TextAlign.left,
                          style: TextStyle(
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
                    Row(
                      children: const [
                        Text(
                          '😡',
                          style: TextStyle(fontSize: 19),
                        ),
                        SizedBox(width: 2),
                        Text(
                          '02',
                          textAlign: TextAlign.left,
                          style: TextStyle(
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
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
