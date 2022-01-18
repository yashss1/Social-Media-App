import 'package:flutter/material.dart';
import 'package:social_media/DashBoard%20Screens/home_page.dart';
import 'package:social_media/Nav%20Drawer%20Screens/blog.dart';
import 'package:social_media/Nav%20Drawer%20Screens/games.dart';
import 'package:social_media/Nav%20Drawer%20Screens/groups.dart';
import 'package:social_media/Nav%20Drawer%20Screens/hashtag.dart';
import 'package:social_media/Nav%20Drawer%20Screens/live_events.dart';
import 'package:social_media/Nav%20Drawer%20Screens/music.dart';
import 'package:social_media/Nav%20Drawer%20Screens/news.dart';
import 'package:social_media/Nav%20Drawer%20Screens/podcast.dart';
import 'package:social_media/Nav%20Drawer%20Screens/shop.dart';
import 'package:social_media/Nav%20Drawer%20Screens/signature_kids.dart';
import 'package:social_media/Nav%20Drawer%20Screens/stream.dart';
import 'package:social_media/Nav%20Drawer%20Screens/trends.dart';
import 'package:social_media/Nav%20Drawer%20Screens/videos.dart';
import 'package:social_media/Services/authentication_helper.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/model/navigation_elements.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  final deviceWidth = 500;
  final deviceHeight = 800;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  splashColor: Colors.pink,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 28,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const NavigationElement(
                            name: 'Home',
                            icon: Icons.home,
                            color1: Colors.black),
                      ),
                      NavigationElement(
                          name: 'Platform',
                          icon: Icons.play_for_work_rounded,
                          color1: Colors.black),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HashTag();
                              },
                            ),
                          );
                        },
                        child: NavigationElement(
                            name: 'HashTag',
                            icon: Icons.bento_sharp,
                            color1: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Games();
                              },
                            ),
                          );
                        },
                        child: NavigationElement(
                            name: 'Games',
                            icon: Icons.videogame_asset_sharp,
                            color1: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SignatureKids();
                              },
                            ),
                          );
                        },
                        child: NavigationElement(
                          name: 'Signature for Kids',
                          icon: Icons.slideshow_sharp,
                          color1: Colors.pink,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Stream();
                              },
                            ),
                          );
                        },
                        child: NavigationElement(
                            name: 'Stream',
                            icon: Icons.play_circle_filled_sharp,
                            color1: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PodCast();
                              },
                            ),
                          );
                        },
                        child: NavigationElement(
                            name: 'Podcast',
                            icon: Icons.podcasts,
                            color1: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LiveEvents();
                              },
                            ),
                          );
                        },
                        child: NavigationElement(
                            name: 'Live Events',
                            icon: Icons.settings_input_antenna,
                            color1: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Music();
                              },
                            ),
                          );
                        },
                        child: NavigationElement(
                            name: 'Music',
                            icon: Icons.music_note,
                            color1: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Videos();
                              },
                            ),
                          );
                        },
                        child: NavigationElement(
                            name: 'Videos',
                            icon: Icons.video_call,
                            color1: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return News();
                              },
                            ),
                          );
                        },
                        child: NavigationElement(
                            name: 'News',
                            icon: Icons.live_help_rounded,
                            color1: Colors.black),
                      ),
                      NavigationElement(
                          name: 'Marketing',
                          icon: Icons.card_membership,
                          color1: Colors.black),
                      NavigationElement(
                          name: 'Find More',
                          icon: Icons.mail_outline,
                          color1: Colors.black),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Trends();
                              },
                            ),
                          );
                        },
                        child: NavigationElement(
                            name: 'Trends',
                            icon: Icons.trending_up_sharp,
                            color1: Colors.black),
                      ),
                      NavigationElement(
                          name: 'Locations',
                          icon: Icons.location_on_rounded,
                          color1: Colors.black),
                      NavigationElement(
                          name: 'Features',
                          icon: Icons.note_sharp,
                          color1: Colors.black),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Shop();
                              },
                            ),
                          );
                        },
                        child: NavigationElement(
                            name: 'Shop',
                            icon: Icons.shopping_cart,
                            color1: Colors.black),
                      ),
                      NavigationElement(
                          name: 'Ads',
                          icon: Icons.tv_sharp,
                          color1: Colors.black),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Blogs();
                              },
                            ),
                          );
                        },
                        child: NavigationElement(
                            name: 'Blog',
                            icon: Icons.speaker_notes,
                            color1: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Groups();
                              },
                            ),
                          );
                        },
                        child: NavigationElement(
                            name: 'Groups',
                            icon: Icons.group,
                            color1: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          AuthenticationHelper().signOut(context);
                        },
                        child: NavigationElement(
                            name: 'Log Out',
                            icon: Icons.logout,
                            color1: Colors.black),
                      ),
                    ],
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
