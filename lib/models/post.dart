import 'package:flutter/material.dart';

class Review {
  final String title;
  final String content;

  Review({required this.title, required this.content});
}

class Comment {
  final String user;
  final String content;

  Comment({required this.user, required this.content});
}

abstract class Post {
  Widget getImageVideo();

  List getListComment();

  int getFavorite();

  Review getReview();

  DateTime getDate();

  int getRate();
}
