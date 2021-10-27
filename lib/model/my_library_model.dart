import 'package:flutter/material.dart';

class LibModel extends StatelessWidget {
  const LibModel({Key? key, required this.img}) : super(key: key);

  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.fitHeight),
      ),
    );
  }
}
