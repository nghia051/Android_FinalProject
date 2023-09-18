import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../../models/post.dart';
import '../../../../models/video_post.dart';
import '../../../../src/appbar.dart';
import '../../../create_post/create_post_popup.dart';
import '../../../create_post/widgets/body_image.dart';

_addVideoNavItem(double height) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: height - 15,
      width: 48,
      margin: EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blueAccent, Colors.redAccent]),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Container(
          width: 41,
          height: height - 15,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    ),
  );
}

XenCardAppBar appBar = XenCardAppBar(
  shadow: BoxShadow(color: Colors.transparent),
  child: Row(
    children: [
      Icon(Icons.account_circle),
      SizedBox(
        width: 15,
      ),
      Expanded(
        child: Text('Restaurant name'),
      ),
      _addVideoNavItem(45),
    ],
  ),
  // To remove shadow from appbar
);
