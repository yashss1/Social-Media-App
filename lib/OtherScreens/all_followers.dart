import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_media/OtherScreens/profile_page.dart';
import 'package:social_media/Services/user_details.dart';
import 'package:social_media/model/friends_model.dart';

import '../constants.dart';

class AllFollowers extends StatefulWidget {
  const AllFollowers({Key? key, this.array}) : super(key: key);

  final array;

  @override
  _AllFollowersState createState() => _AllFollowersState();
}

class _AllFollowersState extends State<AllFollowers> {
  TextEditingController search = TextEditingController();
  String searchField = "";
  var frndList2 = [];
  bool showSpinner = true;

  bool resultData(List arr, int index, String _key) {
    if (arr[index]['Info']['Uid'] == UserDetails.uid) return false;
    String email = arr[index]['Info']['Name'];
    String name = arr[index]['Info']['Username'];
    email = email.toLowerCase();
    name = name.toLowerCase();
    _key = _key.toLowerCase();
    if (email.contains(_key) || name.contains(_key)) return true;
    return false;
  }

  Future getData() async {}

  @override
  void initState() {
    super.initState();
    print(widget.array);
    if (widget.array == null || widget.array.length == 0) {
      showSpinner = false;
    } else {
      getData().then((value) async {
        for (int i = 0; i < widget.array.length; i++) {
          var curr_doc = await FirebaseFirestore.instance
              .collection("Users")
              .doc(widget.array[i]['UID'])
              .get();

          Map<String, dynamic> mp = {
            "Info": {
              'Name': curr_doc['Info']['Name'],
              'Username': curr_doc['Info']['Username'],
              'Email': curr_doc['Info']['Email'],
              'Uid': curr_doc['Info']['Uid'],
              'BgPhotoUrl': curr_doc['Info']['BgPhotoUrl'],
              'ProfilePhotoUrl': curr_doc['Info']['ProfilePhotoUrl'],
              'TagLine': curr_doc['Info']['TagLine'],
              'Profession': curr_doc['Info']['Profession'],
              'Location': curr_doc['Info']['Location'],
              'DOB': curr_doc['Info']['DOB'],
              'PhoneNumber': curr_doc['Info']['PhoneNumber'],
            }
          };
          frndList2.add(mp);
          // print(mp);
          setState(() {
            showSpinner = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            height: deviceHeight,
            width: deviceWidth,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: deviceWidth,
                  height: 70,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 16,
                            child: InkWell(
                              splashColor: Colors.pink,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                size: 28,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: Text(
                                  'Followers',
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
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
                                color: Color.fromRGBO(
                                    0, 0, 0, 0.14000000059604645),
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
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    width: deviceWidth - 32,
                    child: (widget.array == null || widget.array.length == 0)
                        ? Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.pink,
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: frndList2 == null ? 0 : frndList2.length,
                            itemBuilder: (context, index) {
                              return (resultData(
                                          frndList2, index, searchField)) ==
                                      false
                                  ? SizedBox(height: 0)
                                  : InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfilePage(
                                                      array: frndList2,
                                                      index: index,
                                                    )));
                                      },
                                      child: item(
                                        image: frndList2[index]['Info']
                                            ['ProfilePhotoUrl'],
                                        name: frndList2[index]['Info']['Name'],
                                        username: frndList2[index]['Info']
                                            ['Username'],
                                        ontap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage(
                                                        array: frndList2,
                                                        index: index,
                                                      )));
                                        },
                                      ),
                                    );
                            }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class item extends StatelessWidget {
  final String image, name, username;
  final Function()? ontap;

  const item({
    Key? key,
    this.ontap,
    required this.image,
    required this.name,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(100, 94, 94, 1),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider("${image}"),
                        fit: BoxFit.fitWidth),
                    borderRadius: BorderRadius.all(Radius.elliptical(36, 36)),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${name}',
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
                      '@${username}',
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
                  ],
                ),
              ],
            ),
            Container(
              width: 100,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: const Color.fromRGBO(255, 255, 255, 1),
                border: Border.all(
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  width: 1,
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  child: Text(
                    'View profile',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Lato',
                        fontSize: 16,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
