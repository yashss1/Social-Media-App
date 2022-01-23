import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommentModelz extends StatefulWidget {
  const CommentModelz({Key? key, this.array, this.index}) : super(key: key);

  final array, index;

  @override
  _CommentModelzState createState() => _CommentModelzState();
}

class _CommentModelzState extends State<CommentModelz> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(100, 94, 94, 1),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          '${widget.array[widget.index]['ProfilePhotoUrl']}'),
                      fit: BoxFit.fitWidth),
                  borderRadius: BorderRadius.all(Radius.elliptical(36, 36)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Container(
            width: deviceWidth - 78,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${widget.array[widget.index]['Name']}",
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
                  "@${widget.array[widget.index]['Username']}",
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
                Text(
                  "${widget.array[widget.index]['Comment']}",
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
                SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
