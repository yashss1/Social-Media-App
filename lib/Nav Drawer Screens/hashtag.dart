import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/OtherScreens/individual_hashtag2.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/model/hashtag_model.dart';

class HashTag extends StatefulWidget {
  const HashTag({Key? key}) : super(key: key);

  @override
  _HashTagState createState() => _HashTagState();
}

class _HashTagState extends State<HashTag> {
  TextEditingController search = TextEditingController();
  String searchField = "";

  bool resultData(List arr, int index, String _key) {
    String name = arr[index]['Name'];
    name = name.toLowerCase();
    _key = _key.toLowerCase();
    if (name.contains(_key)) return true;
    return false;
  }

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
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              //   height: 70,
              //   width: deviceWidth,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         'For You',
              //         textAlign: TextAlign.left,
              //         style: TextStyle(
              //             color: pink,
              //             fontFamily: 'Lato',
              //             fontSize: 16,
              //             letterSpacing:
              //                 0 /*percentages not used in flutter. defaulting to zero*/,
              //             fontWeight: FontWeight.normal,
              //             height: 1),
              //       ),
              //       const Text(
              //         'Internation Hastag',
              //         textAlign: TextAlign.left,
              //         style: TextStyle(
              //             color: Colors.black,
              //             fontFamily: 'Lato',
              //             fontSize: 16,
              //             letterSpacing:
              //                 0 /*percentages not used in flutter. defaulting to zero*/,
              //             fontWeight: FontWeight.normal,
              //             height: 1),
              //       ),
              //       const Text(
              //         'National HashTag',
              //         textAlign: TextAlign.left,
              //         style: TextStyle(
              //             color: Colors.black,
              //             fontFamily: 'Lato',
              //             fontSize: 16,
              //             letterSpacing:
              //                 0 /*percentages not used in flutter. defaulting to zero*/,
              //             fontWeight: FontWeight.normal,
              //             height: 1),
              //       ),
              //     ],
              //   ),
              // ),
              // const Divider(
              //   height: 5,
              //   color: Colors.grey,
              // ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                width: deviceWidth,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  color: Color.fromRGBO(226, 226, 226, 0.3199999928474426),
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: deviceWidth - 100,
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: search,
                        onChanged: (text) {
                          setState(() {
                            searchField = text;
                            // print(searchField);
                          });
                        },
                        decoration: kMessageTextFieldDecoration.copyWith(
                          hintText: "Search",
                        ),
                      ),
                    ),
                    Container(
                      width: 55,
                      height: 55,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Color.fromRGBO(0, 0, 0, 0.14000000059604645),
                              offset: Offset(1, 1),
                              blurRadius: 12)
                        ],
                        color: Color.fromRGBO(255, 79, 90, 1),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              // Expanded(
              //   child: Container(
              //     padding: EdgeInsets.symmetric(horizontal: 16),
              //     child: SingleChildScrollView(
              //       physics: BouncingScrollPhysics(),
              //       child: Column(
              //         children: [
              //           SizedBox(height: 25),
              //           HashTagModel(
              //               num: '1', name: 'WorldNews', people: '39.6k'),
              //           HashTagModel(
              //               num: '2',
              //               name: 'Greatestofalltime',
              //               people: '396k'),
              //           HashTagModel(num: '3', name: 'usa', people: '3.6k'),
              //           HashTagModel(num: '4', name: 'terror', people: '39.6k'),
              //           HashTagModel(
              //               num: '5', name: 'gamingyt', people: '3.6k'),
              //           HashTagModel(
              //               num: '6', name: 'breakingnews', people: '39.6k'),
              //           HashTagModel(
              //               num: '7', name: 'usavschina', people: '39.6k'),
              //           HashTagModel(num: '8', name: 'cricket', people: '9.6k'),
              //           HashTagModel(
              //               num: '9', name: 'shanewarne', people: '39k'),
              //           HashTagModel(num: '10', name: 'sony', people: '600'),
              //           HashTagModel(
              //               num: '11', name: 'healthNews', people: '45K'),
              //           HashTagModel(
              //               num: '1', name: 'WorldNews', people: '39.6k'),
              //           HashTagModel(
              //               num: '2',
              //               name: 'Greatestofalltime',
              //               people: '396k'),
              //           HashTagModel(num: '3', name: 'usa', people: '3.6k'),
              //           HashTagModel(num: '4', name: 'terror', people: '39.6k'),
              //           HashTagModel(
              //               num: '5', name: 'gamingyt', people: '3.6k'),
              //           HashTagModel(
              //               num: '6', name: 'breakingnews', people: '39.6k'),
              //           HashTagModel(
              //               num: '7', name: 'usavschina', people: '39.6k'),
              //           HashTagModel(num: '8', name: 'cricket', people: '9.6k'),
              //           HashTagModel(
              //               num: '9', name: 'shanewarne', people: '39k'),
              //           HashTagModel(num: '10', name: 'sony', people: '600'),
              //           HashTagModel(
              //               num: '11', name: 'healthNews', people: '45K'),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('HashTags')
                        .snapshots(),
                    builder: (ctx, AsyncSnapshot snaps) {
                      if (snaps.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final _snap = snaps.data!.docs;
                      return _snap.length == 0
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .3,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "WE'RE SORRY",
                                  ),
                                  Center(
                                    child: Text(
                                      "There is Nothing here...",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: _snap.length,
                              itemBuilder: (context, index) {
                                return (resultData(
                                            _snap, index, searchField)) ==
                                        false
                                    ? SizedBox(height: 0)
                                    : InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  IndividualHashtag2(
                                                hashtag: _snap[index]['Name'],
                                              ),
                                            ),
                                          );
                                        },
                                        child: HashTagModel(
                                          num: '${(index + 1)}',
                                          name: _snap[index]['Name'],
                                          people:
                                              '${_snap[index]['Posts'].length}',
                                        ),
                                      );
                              });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
