import 'package:antap/screens/image_video_post/customize_screen.dart';
import 'package:antap/screens/map/map_screen.dart';
import 'package:antap/screens/map/pop_up/popup_screen.dart';
import 'package:antap/screens/posts/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:antap/screens/reels/widgets/custom_bottom_navigation_bar.dart';
import 'package:antap/screens/reels/home_page.dart';

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
    PopUp(),
    //CustomizeScreen(address: address)
  ];

  void _onIconTapped(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectPageIndex],
      ),
      bottomNavigationBar: CustomerBottomNavigationBar(
          selectedPageIndex: _selectPageIndex, onIconTap: _onIconTapped),
    );
  }
}
