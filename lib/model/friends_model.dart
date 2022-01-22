import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FriendModel extends StatelessWidget {
  const FriendModel({Key? key, required this.name, required this.img})
      : super(key: key);

  final String name, img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
              width: 90,
              height: 93,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.transparent,
                image: DecorationImage(
                    image: CachedNetworkImageProvider(img),
                    fit: BoxFit.fitWidth),
              )),
          SizedBox(height: 5),
          Container(
            width: 90,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1.0),
                  overflow: TextOverflow.ellipsis,
                  fontFamily: 'Lato',
                  fontSize: 18,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
          ),
        ],
      ),
    );
  }
}
