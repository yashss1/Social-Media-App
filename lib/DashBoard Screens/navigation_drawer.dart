import 'package:flutter/material.dart';
import 'package:social_media/Nav%20Drawer%20Screens/signature_kids.dart';
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
            SingleChildScrollView(
              child: Column(
                children: [
                  NavigationElement(
                      name: 'Home', icon: Icons.home, color1: Colors.black),
                  NavigationElement(
                      name: 'Platform',
                      icon: Icons.play_for_work_rounded,
                      color1: Colors.black),
                  NavigationElement(
                      name: 'Games',
                      icon: Icons.videogame_asset_sharp,
                      color1: Colors.black),
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
                  NavigationElement(
                      name: 'Stream',
                      icon: Icons.play_circle_filled_sharp,
                      color1: Colors.black),
                  NavigationElement(
                      name: 'Podcast',
                      icon: Icons.podcasts,
                      color1: Colors.black),
                  NavigationElement(
                      name: 'Live Events',
                      icon: Icons.settings_input_antenna,
                      color1: Colors.black),
                  NavigationElement(
                      name: 'Music',
                      icon: Icons.music_note,
                      color1: Colors.black),
                  NavigationElement(
                      name: 'Videos',
                      icon: Icons.video_call,
                      color1: Colors.black),
                  NavigationElement(
                      name: 'News',
                      icon: Icons.live_help_rounded,
                      color1: Colors.black),
                  NavigationElement(
                      name: 'Marketing',
                      icon: Icons.card_membership,
                      color1: Colors.black),
                  NavigationElement(
                      name: 'Find More',
                      icon: Icons.mail_outline,
                      color1: Colors.black),
                  NavigationElement(
                      name: 'Trends',
                      icon: Icons.trending_up_sharp,
                      color1: Colors.black),
                  NavigationElement(
                      name: 'Locations',
                      icon: Icons.location_on_rounded,
                      color1: Colors.black),
                  NavigationElement(
                      name: 'Features',
                      icon: Icons.note_sharp,
                      color1: Colors.black),
                  NavigationElement(
                      name: 'Shop',
                      icon: Icons.shopping_cart,
                      color1: Colors.black),
                  NavigationElement(
                      name: 'Ads', icon: Icons.tv_sharp, color1: Colors.black),
                  NavigationElement(
                      name: 'Blog',
                      icon: Icons.speaker_notes,
                      color1: Colors.black),
                  NavigationElement(
                      name: 'Groups', icon: Icons.group, color1: Colors.black),
                  NavigationElement(
                      name: 'Log Out',
                      icon: Icons.logout,
                      color1: Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
