import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String title;
  final String content;

  Review({
    required this.title,
    required this.content
  });
}

class Post {
  final String coverUrl;
  final List<String> listImageUrl;
  final DateTime? postDate;
  final int rate;
  final Review review;
  
  Post({
    required this.coverUrl,
    required this.listImageUrl,
    required this.postDate,
    required this.rate,
    required this.review
  });

  factory Post.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Post(
      coverUrl: data?["coverUrl"],
      listImageUrl: List<String>.from(data?["listImageUrl"]),
      postDate: data?["postDate"],
      rate: data?["rate"],
      review: Review(
        title: data?["review"]["title"],
        content: data?["review"]["content"]
      )
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "coverUrl": coverUrl,
      "listImageUrl": listImageUrl,
      "postDate": postDate,
      "rate": rate,
      "review": {
        "title": review.title,
        "content": review.content
      }
    };
  }
}