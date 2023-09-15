import 'package:antap/models/post.dart';
import 'package:antap/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/posts/components/post_image_widget.dart';

class ImagePost extends Post {
  String coverUrl;
  List<String> listImageUrl;
  User postedBy;
  DateTime postDate;
  int rate;
  Review review;
  int favorite;
  List<Comment> listComment;

  ImagePost(
      {required this.coverUrl,
      required this.listImageUrl,
      required this.postedBy,
      required this.postDate,
      required this.rate,
      required this.review,
      required this.favorite,
      required this.listComment});

  @override
  Widget getImageVideo() {
    return PostImageWidget(post: this);
  }

  @override
  User getUser() {
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

  // factory ImagePost.fromFireStore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return ImagePost(
  //       coverUrl: data?["coverUrl"],
  //       listImageUrl: List<String>.from(data?["listImageUrl"]),
  //       postDate: data?["postDate"],
  //       rate: data?["rate"],
  //       review: Review(
  //           title: data?["review"]["title"],
  //           content: data?["review"]["content"]),
  //       favorite: data?["favorite"],
  //       listComment: (data?["listComment"] as List<dynamic>).map((commentData) {
  //         return Comment(
  //           user: commentData["user"],
  //           content: commentData["content"],
  //         );
  //       }).toList());
  // }

  // Map<String, dynamic> toFireStore() {
  //   return {
  //     "coverUrl": coverUrl,
  //     "listImageUrl": listImageUrl,
  //     "postDate": postDate,
  //     "rate": rate,
  //     "review": {"title": review.title, "content": review.content},
  //     "favorite": favorite,
  //     "listComment": listComment
  //   };
  // }
}
