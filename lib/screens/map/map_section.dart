import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSection extends StatefulWidget {
  const MapSection({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MapSectionState();
  }
}

class _MapSectionState extends State<MapSection> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _hcmusPos = CameraPosition(
    target: LatLng(10.762729, 106.682493),
    zoom: 17,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _hcmusPos,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
