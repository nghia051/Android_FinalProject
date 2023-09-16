import 'package:antap/screens/image_video_post/customize_screen.dart';
import 'package:antap/screens/map/map_screen.dart';
import 'package:antap/screens/map/pop_up/popup_screen.dart';
import 'package:antap/screens/posts/post_screen.dart';
import 'package:antap/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:antap/screens/reels/widgets/custom_bottom_navigation_bar.dart';
import 'package:antap/screens/reels/home_page.dart';
import 'package:antap/screens/create_post/create_post_popup.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static String id = "main_screen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectPageIndex = 0;

  static const List<Widget> _pages = [
    HomePage(),
    PostScreen(),
    MapScreen(),
    CustomizeScreen(),
    CreatePostPopUp(),
    ProfileScreen(),
  ];

  void _onIconTapped(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      body: _pages[_selectPageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.black,
        height: 50,
        index: _selectPageIndex,
        onTap: (index) {
          setState(() {
            _selectPageIndex = index;
          });
        },
        items: <Widget>[
          Icon(
            Icons.home,
            size: 26,
            color: Colors.black,
          ),
          Icon(
            Icons.store,
            size: 26,
            color: Colors.black,
          ),
          Icon(
            Icons.location_on,
            size: 26,
            color: Colors.black,
          ),
          Icon(
            Icons.favorite,
            size: 26,
            color: Colors.black,
          ),
          Icon(
            Icons.account_circle,
            size: 26,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
