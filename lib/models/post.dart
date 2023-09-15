import 'package:antap/models/user.dart';
import 'package:flutter/material.dart';

class Review {
  final String title;
  final String content;

  Review({required this.title, required this.content});
}

class Comment {
  final User user;
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

  User getUser();

  void updateFavorite(int val);
}
