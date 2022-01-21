import 'package:flutter/material.dart';
import 'package:social_media/DashBoard%20Screens/home_page.dart';
import 'package:social_media/DashBoard%20Screens/message_page.dart';
import 'package:social_media/DashBoard%20Screens/navigation_drawer.dart';
import 'package:social_media/DashBoard%20Screens/search_page.dart';
import 'package:social_media/DashBoard%20Screens/user_page.dart';
import 'package:social_media/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _myPage = PageController(initialPage: 0);
  var curr_page = 0;

  _onPageViewChange(int page) {
    setState(() {});
    curr_page = page;
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: NavigationDrawer(),
        backgroundColor: Colors.grey,
        body: SingleChildScrollView(
          child: Container(
            width: deviceWidth,
            height: deviceHeight - 35,
            child: Stack(
              children: [
                Container(
                  width: deviceWidth,
                  height: deviceHeight,
                  child: PageView(
                    controller: _myPage,
                    children: const <Widget>[
                      Home(),
                      SearchPage(),
                      MessagePage(),
                      UserPage(),
                    ],
                    onPageChanged: _onPageViewChange,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    // margin: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                    padding: EdgeInsets.all(16),
                    width: deviceWidth,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        // bottomLeft: Radius.circular(43),
                        // bottomRight: Radius.circular(43),
                      ),
                      color: Color.fromRGBO(255, 255, 255, 1),
                      border: Border.all(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _myPage.jumpToPage(0);
                            });
                          },
                          child: Icon(
                            Icons.home,
                            size: 35,
                            color: curr_page == 0 ? pink : Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _myPage.jumpToPage(1);
                            });
                          },
                          child: Icon(
                            Icons.search,
                            size: 35,
                            color: curr_page == 1 ? pink : Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _myPage.jumpToPage(2);
                            });
                          },
                          child: Icon(
                            Icons.chat,
                            size: 35,
                            color: curr_page == 2 ? pink : Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _myPage.jumpToPage(3);
                            });
                          },
                          child: Icon(
                            Icons.account_circle,
                            size: 35,
                            color: curr_page == 3 ? pink : Colors.grey,
                          ),
                        ),
                      ],
                    ),
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
