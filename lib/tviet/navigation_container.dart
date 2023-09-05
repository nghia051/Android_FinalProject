import 'package:flutter/material.dart';
import 'package:tiktok_app/pages/add_video_page.dart';
import 'package:tiktok_app/pages/discover_page.dart';
import 'package:tiktok_app/pages/profile_page.dart';
import 'package:tiktok_app/widgets/custom_bottom_navigation_bar.dart';

import 'pages/home_page.dart';
import 'pages/inbox_page.dart';

class NavigationContainer extends StatefulWidget {
  const NavigationContainer({super.key});

  @override
  State<NavigationContainer> createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer> {
  int _selectPageIndex = 0;

  static const List<Widget> _pages = [
    HomePage(),
    DiscoverPage(),
    AddVideoPage(),
    InboxPage(),
    ProfilePage(),
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
