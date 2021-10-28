import 'package:flutter/material.dart';
import 'package:social_media/constants.dart';

class TopEpisode extends StatelessWidget {
  const TopEpisode({Key? key, required this.img, required this.name, required this.ep, required this.min}) : super(key: key);

  final String img, name, ep, min;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 133,
                height: 102,
                decoration:  BoxDecoration(
                  borderRadius: const BorderRadius.only(
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
          SizedBox(width: 17),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                name,
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
              SizedBox(height: 10),
              Container(
                width: deviceWidth * .5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      '$ep Episode',
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
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.6100000143051147),
                        borderRadius: BorderRadius.all(Radius.elliptical(7, 7)),
                      ),
                    ),
                     Text(
                      '$min Minutes',
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
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.play_circle_filled_sharp,
                    color: pink,
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  const Text(
                    'Listen now',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 79, 90, 1),
                        fontFamily: 'Lato',
                        fontSize: 16,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
