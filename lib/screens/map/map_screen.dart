import 'package:antap/screens/map/map_section.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  static String id = 'map_screen';

  @override
  State<StatefulWidget> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              "Map",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          )),
      body: const MapSection(),
    ));
  }
}
