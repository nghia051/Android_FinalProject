import 'package:antap/screens/create_post/widgets/body_video.dart';
import 'package:antap/screens/create_post/widgets/body_image.dart';
import 'package:flutter/material.dart';

class TabBarApp extends StatelessWidget {
  String resID;
  TabBarApp({required this.resID, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: TabBarExample(resID: resID),
    );
  }
}

class TabBarExample extends StatelessWidget {
  String resID;
  TabBarExample({required this.resID, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          //title: const Text('TabBar Sample'),
          title: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.add_photo_alternate),
              ),
              Tab(
                icon: Icon(Icons.video_collection),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CreateImagePostScreen(resID: resID),
            CreateVideoPostScreen(resID: resID),
          ],
        ),
      ),
    );
  }
}
