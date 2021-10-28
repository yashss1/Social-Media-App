import 'package:flutter/material.dart';

class GroupsModel extends StatelessWidget {
  const GroupsModel(
      {Key? key,
      required this.img,
      required this.grpName,
      required this.members})
      : super(key: key);

  final String img, grpName, members;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(196, 196, 196, 1),
                      image: DecorationImage(
                          image: AssetImage(img), fit: BoxFit.fitHeight),
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(52, 52)),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    grpName,
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
                  const SizedBox(height: 5),
                  Text(
                    '$members members',
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
            ],
          ),
          Column(
            children: [
              Container(
                width: 63,
                height: 31,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                  color: Color.fromRGBO(255, 79, 90, 1),
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Join',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Lato',
                        fontSize: 16,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
