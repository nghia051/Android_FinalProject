import 'package:flutter/material.dart';

import '../../../../src/appbar.dart';

XenCardAppBar appBar = const XenCardAppBar(
  shadow: BoxShadow(color: Colors.transparent),
  child: Row(
    children: [
      Icon(Icons.account_circle),
      SizedBox(
        width: 15,
      ),
      Expanded(
        child: Text('Create Post'),
      ),
      Icon(Icons.add, color: Colors.black),
    ],
  ),
  // To remove shadow from appbar
);
