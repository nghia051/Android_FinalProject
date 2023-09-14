import 'package:flutter/material.dart';

import '../../../../src/appbar.dart';

Container _addVideoNavItem = Container(
  // height: height - 15,
  width: 48,
  margin: EdgeInsets.only(bottom: 4),
  decoration: BoxDecoration(
    gradient: LinearGradient(colors: [Colors.blueAccent, Colors.redAccent]),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Center(
    child: Container(
      width: 41,
      // height: height - 15,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons.add, color: Colors.white),
    ),
  ),
);

XenCardAppBar appBar = const XenCardAppBar(
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
      Icon(Icons.add, color: Colors.black),
    ],
  ),
  // To remove shadow from appbar
);
