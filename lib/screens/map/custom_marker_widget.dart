import 'package:flutter/material.dart';

class CustomMarkerWidget extends StatelessWidget {
  final Image img;

  const CustomMarkerWidget({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: img.image, fit: BoxFit.fill),
      ),
    );
  }
}
