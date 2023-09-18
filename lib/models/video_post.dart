import 'package:antap/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/map/pop_up/widgets/video_app.dart';
import 'post.dart';

class VideoPost extends Post {
  String videoUrl;
  String? postedBy;
  DateTime postDate;
  int rate;
  Review review;
  int favorite;
  List<Comment> listComment;
  String audioName;
  String resID;

  VideoPost(this.videoUrl, this.postedBy, this.postDate, this.rate, this.review,
      this.favorite, this.listComment, this.audioName, this.resID);

  @override
  String getResID() {
    return resID;
  }

  @override
  Widget getImageVideo() {
    return VideoPlayerScreen(
      video: this,
    );
  }

  @override
  String? getUser() {
    return postedBy;
  }

  @override
  List getListComment() {
    return listComment;
  }

  @override
  int getFavorite() {
    return favorite;
  }

  @override
  Review getReview() {
    return review;
  }

  @override
  DateTime getDate() {
    return postDate;
  }

  @override
  int getRate() {
    return rate;
  }

  @override
  void updateFavorite(int val) {
    favorite += val;
  }

  @override
  void updateComment(Comment comment) {
    listComment.add(comment);
  }

  @override
  factory VideoPost.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return VideoPost(
      data?["videoUrl"],
      data?["postedBy"],
      data?["postDate"].toDate(),
      data?["rate"],
      Review(
          title: data?["review"]["title"], content: data?["review"]["content"]),
      data?["favorite"],
      (data?["listComment"] as List<dynamic>).map((commentData) {
        return Comment(
          user: "Hoang Nghia Viet",
          content: commentData["content"],
        );
      }).toList(),
      data?["audioName"],
      data?["resID"],
    );
  }
}

dynamic getListMap(List<dynamic> items) {
  if (items == null) {
    return null;
  }
  List<Map<String, dynamic>> list = [];
  items.forEach((element) {
    list.add(element.toJson());
  });
  return list;
}
