import 'package:flutter/material.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/model/hashtag_model.dart';

class HashTag extends StatefulWidget {
  const HashTag({Key? key}) : super(key: key);

  @override
  _HashTagState createState() => _HashTagState();
}

class _HashTagState extends State<HashTag> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: deviceWidth,
          height: deviceHeight,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: deviceWidth,
                height: 70,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          splashColor: Colors.pink,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            size: 28,
                          ),
                        ),
                        SizedBox(width: 25),
                        const Text(
                          'HashTag',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 79, 90, 1),
                              fontFamily: 'Lato',
                              fontSize: 20,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 5,
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                width: deviceWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'For You',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: pink,
                          fontFamily: 'Lato',
                          fontSize: 16,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    const Text(
                      'Internation Hastag',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lato',
                          fontSize: 16,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    const Text(
                      'National HashTag',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
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
              const Divider(
                height: 5,
                color: Colors.grey,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: 25),
                        HashTagModel(
                            num: '1', name: 'WorldNews', people: '39.6k'),
                        HashTagModel(
                            num: '2',
                            name: 'Greatestofalltime',
                            people: '396k'),
                        HashTagModel(num: '3', name: 'usa', people: '3.6k'),
                        HashTagModel(num: '4', name: 'terror', people: '39.6k'),
                        HashTagModel(
                            num: '5', name: 'gamingyt', people: '3.6k'),
                        HashTagModel(
                            num: '6', name: 'breakingnews', people: '39.6k'),
                        HashTagModel(
                            num: '7', name: 'usavschina', people: '39.6k'),
                        HashTagModel(num: '8', name: 'cricket', people: '9.6k'),
                        HashTagModel(
                            num: '9', name: 'shanewarne', people: '39k'),
                        HashTagModel(num: '10', name: 'sony', people: '600'),
                        HashTagModel(
                            num: '11', name: 'healthNews', people: '45K'),
                        HashTagModel(
                            num: '1', name: 'WorldNews', people: '39.6k'),
                        HashTagModel(
                            num: '2',
                            name: 'Greatestofalltime',
                            people: '396k'),
                        HashTagModel(num: '3', name: 'usa', people: '3.6k'),
                        HashTagModel(num: '4', name: 'terror', people: '39.6k'),
                        HashTagModel(
                            num: '5', name: 'gamingyt', people: '3.6k'),
                        HashTagModel(
                            num: '6', name: 'breakingnews', people: '39.6k'),
                        HashTagModel(
                            num: '7', name: 'usavschina', people: '39.6k'),
                        HashTagModel(num: '8', name: 'cricket', people: '9.6k'),
                        HashTagModel(
                            num: '9', name: 'shanewarne', people: '39k'),
                        HashTagModel(num: '10', name: 'sony', people: '600'),
                        HashTagModel(
                            num: '11', name: 'healthNews', people: '45K'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
