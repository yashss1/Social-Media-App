import 'package:flutter/material.dart';

class IconButton1 extends StatelessWidget {
  const IconButton1({Key? key, required this.icons}) : super(key: key);

  final String icons;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 67,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
              offset: Offset(0, 2),
              blurRadius: 7)
        ],
        color: const Color.fromRGBO(255, 255, 255, 1),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          icons,
          scale: 1.6,
        ),
      ),
    );
  }
}
