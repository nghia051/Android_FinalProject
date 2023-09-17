import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  String id = 'id';
  String name = 'name';
  String imageUrl = 'imageUrl';
  LatLng location = LatLng(10.762899, 106.682580);

  Restaurant({ required this.id, required this.name, required this.imageUrl, required this.location});

  @override
  factory Restaurant.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Restaurant(
        id: "",
        name: data?["name"],
        imageUrl: data?["imageUrl"],
        location: LatLng(data?["latitude"], data?["longtitude"])
      );
  }
}
