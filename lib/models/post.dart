import 'package:antap/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Review {
  final String title;
  final String content;

  Review({required this.title, required this.content});

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}

class Comment {
  final String user;
  final String content;

  Map<String, Object?> toJson() {
    return {
      'user': user,
      'content': content,
    };
  }

  Comment({required this.user, required this.content});
}

abstract class Post {
  Post();

  Widget getImageVideo();

  List getListComment();

  int getFavorite();

  Review getReview();

  DateTime getDate();

  int getRate();

  String? getUser();

  void updateFavorite(int val);

  void updateComment(Comment comment);
}
