import 'package:antap/data/data.dart';
import 'package:antap/models/post.dart';
import 'package:antap/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/posts/components/post_image_widget.dart';

class ImagePost extends Post {
  String id;
  List<String> listImageUrl;
  String postedBy;
  DateTime postDate;
  int rate;
  Review review;
  int favorite;
  List<Comment> listComment;

  ImagePost(
      {required this.id,
      required this.listImageUrl,
      required this.postedBy,
      required this.postDate,
      required this.rate,
      required this.review,
      required this.favorite,
      required this.listComment});

  @override
  String getID() {
    return id;
  }

  @override
  Widget getImageVideo() {
    return PostImageWidget(post: this);
  }

  @override
  String getUser() {
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
  factory ImagePost.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ImagePost(
      id: data?["id"],
      listImageUrl: List<String>.from(data?["listImageUrl"]),
      postDate: data?["postDate"].toDate(),
      postedBy: "Hoang Nghia Viet",
      rate: data?["rate"],
      review: Review(
          title: data?["review"]["title"],
          content: data?["review"]["content"]),
      favorite: data?["favorite"],
      listComment: (data?["listComment"] as List<dynamic>).map((commentData) {
        return Comment(
          user: "Hoang Nghia Viet",
          content: commentData["content"],
        );
      }).toList());
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "listImageUrl": listImageUrl,
      "postedBy": postedBy,
      "postDate": postDate,
      "rate": rate,
      "review": {"title": review.title, "content": review.content},
      "favorite": favorite,
      "listComment": listComment
    };
  }
}
