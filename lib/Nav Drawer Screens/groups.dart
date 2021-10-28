import 'package:flutter/material.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/model/groups_model.dart';

class Groups extends StatefulWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
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
                        const SizedBox(width: 25),
                        const Text(
                          'Groups',
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
                    Row(
                      children: const [
                        Icon(
                          Icons.search,
                          size: 30,
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
                  children: const [
                    Text(
                      'Groups',
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
                    Text(
                      'Discover',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.pink,
                          fontFamily: 'Lato',
                          fontSize: 16,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    Text(
                      'Create Groups',
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
                    Text(
                      'Invite',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Lato',
                          fontSize: 16,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    )
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 15),
                        Text(
                          'Suggested for you',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Lato',
                              fontSize: 18,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        SizedBox(height: 15),
                        GroupsModel(
                            img: 'assets/images/Ellipse120.png',
                            grpName: 'Meet with Friends',
                            members: '152,548'),
                        GroupsModel(
                            img: 'assets/images/Ellipse121.png',
                            grpName: 'Current Affairs',
                            members: '50,548'),
                        GroupsModel(
                            img: 'assets/images/Ellipse121.png',
                            grpName: 'Current Affairs',
                            members: '50,548'),
                        GroupsModel(
                            img: 'assets/images/Ellipse121.png',
                            grpName: 'Current Affairs',
                            members: '50,548'),
                        GroupsModel(
                            img: 'assets/images/Ellipse121.png',
                            grpName: 'Current Affairs',
                            members: '50,548'),
                        GroupsModel(
                            img: 'assets/images/Ellipse121.png',
                            grpName: 'Current Affairs',
                            members: '50,548'),
                        GroupsModel(
                            img: 'assets/images/Ellipse121.png',
                            grpName: 'Current Affairs',
                            members: '50,548'),
                        GroupsModel(
                            img: 'assets/images/Ellipse121.png',
                            grpName: 'Current Affairs',
                            members: '50,548'),
                        GroupsModel(
                            img: 'assets/images/Ellipse121.png',
                            grpName: 'Current Affairs',
                            members: '50,548'),
                        GroupsModel(
                            img: 'assets/images/Ellipse121.png',
                            grpName: 'Current Affairs',
                            members: '50,548'),
                        GroupsModel(
                            img: 'assets/images/Ellipse121.png',
                            grpName: 'Current Affairs',
                            members: '50,548'),
                        GroupsModel(
                            img: 'assets/images/Ellipse121.png',
                            grpName: 'Current Affairs',
                            members: '50,548'),
                        GroupsModel(
                            img: 'assets/images/Ellipse121.png',
                            grpName: 'Current Affairs',
                            members: '50,548'),
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
