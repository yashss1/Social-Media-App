import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_media/OtherScreens/profile_page.dart';

class CommentModelz extends StatefulWidget {
  const CommentModelz({Key? key, this.array, this.index}) : super(key: key);

  final array, index;

  @override
  _CommentModelzState createState() => _CommentModelzState();
}

class _CommentModelzState extends State<CommentModelz> {
  String date = "", time = "";

  @override
  void initState() {
    super.initState();
    DateTime myDateTime = widget.array[widget.index]['createdAt'].toDate();
    DateTime currentDateTime = Timestamp.now().toDate();
    String formattedDateTime =
        DateFormat('dd-MM-yyyy – hh:mm a').format(myDateTime);
    String formattedDateTimecurr =
        DateFormat('dd-MM-yyyy – hh:mm a').format(currentDateTime);
    String s1 = formattedDateTime.substring(0, 10);
    String s2 = formattedDateTimecurr.substring(0, 10);

    String formatDate = DateFormat.yMMMEd().format(myDateTime);
    print(formatDate);
    if (s1 == s2) {
      date = "";
      time = formattedDateTime.substring(13);
    } else {
      date = formatDate.substring(4, 11);
      time = formattedDateTime.substring(13);
    }
  }

  // Tag User Function (redirect to UserPage)
  Future getUserFromUsername(String word) async {
    word = word.substring(1);
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('Users').get();

    final _snap = snap.docs;
    // print(word);
    for (int i = 0; i < _snap.length; i++) {
      // bc khupch vel lagla
      // print(_snap[i]['Info']['Uid']);
      // print(_snap[i]['Info']['Username']);
      if (_snap[i]['Info']['Username'] == word) {
        /// Write your method here
        print(_snap[i]['Info']['Uid']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              array: _snap,
              index: i,
            ),
          ),
        );
      }
    }
  }

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
                  "${date} ${time}",
                  textAlign: TextAlign.left,
                  maxLines: 5,
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.949999988079071),
                      fontFamily: 'Lato',
                      fontSize: 12,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                SizedBox(height: 10),
                // Text(
                //   "${widget.array[widget.index]['Comment']}",
                //   textAlign: TextAlign.left,
                //   maxLines: 5,
                //   style: TextStyle(
                //       color: Color.fromRGBO(0, 0, 0, 0.949999988079071),
                //       fontFamily: 'Lato',
                //       fontSize: 15,
                //       letterSpacing:
                //           0 /*percentages not used in flutter. defaulting to zero*/,
                //       fontWeight: FontWeight.normal,
                //       height: 1),
                // ),
                RichText(
                  text: TextSpan(
                      children: widget.array[widget.index]['Comment']
                          .split(" ")
                          .map<InlineSpan>(
                    //ithe pn khup vel lagla (40min) inlinespan error
                    (word) {
                      // print(word);
                      if (word.startsWith('@')) {
                        return TextSpan(
                            text: '$word ',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 17.0),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                getUserFromUsername(word).then((value) {});
                              });
                      }
                      return TextSpan(
                          text: '$word ',
                          style: const TextStyle(
                              fontSize: 17.0, color: Colors.black));
                    },
                  ).toList()),
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
