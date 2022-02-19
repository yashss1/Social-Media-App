import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Story1 extends StatelessWidget {
  const Story1({Key? key, required this.bg, required this.img})
      : super(key: key);

  final String bg, img;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      width: 90,
      height: 140,
      child: Stack(
        children: [
          Container(
              width: 90,
              height: 125,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: const Color.fromRGBO(196, 196, 196, 1),
                image: DecorationImage(
                    image: CachedNetworkImageProvider("${bg}"),
                    fit: BoxFit.cover),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(100, 94, 94, 1),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider("${img}"),
                      fit: BoxFit.cover),
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(36, 36)),
                )),
          )
        ],
      ),
    );
  }
}
