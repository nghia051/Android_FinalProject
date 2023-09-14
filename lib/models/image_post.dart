import 'package:antap/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class ImagePost extends Post {
  final String coverUrl;
  final List<String> listImageUrl;
  final DateTime postDate;
  final int rate;
  final Review review;
  final int favorite;
  final List<Comment> listComment;

  ImagePost(
      {required this.coverUrl,
      required this.listImageUrl,
      required this.postDate,
      required this.rate,
      required this.review,
      required this.favorite,
      required this.listComment});

  factory ImagePost.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ImagePost(
        coverUrl: data?["coverUrl"],
        listImageUrl: List<String>.from(data?["listImageUrl"]),
        postDate: data?["postDate"],
        rate: data?["rate"],
        review: Review(
            title: data?["review"]["title"],
            content: data?["review"]["content"]),
        favorite: data?["favorite"],
        listComment: (data?["listComment"] as List<dynamic>).map((commentData) {
          return Comment(
            user: commentData["user"],
            content: commentData["content"],
          );
        }).toList());
  }

  Map<String, dynamic> toFireStore() {
    return {
      "coverUrl": coverUrl,
      "listImageUrl": listImageUrl,
      "postDate": postDate,
      "rate": rate,
      "review": {"title": review.title, "content": review.content},
      "favorite": favorite,
      "listComment": listComment
    };
  }
}
