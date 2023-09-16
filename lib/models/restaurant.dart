import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Restaurant {
  
  String id = 'id';
  String name = 'name';
  String imageUrl = 'imageUrl';
  LatLng location = LatLng(10.762899, 106.682580);

  Restaurant(this.id, this.name, this.imageUrl, this.location);
}
