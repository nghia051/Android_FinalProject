import 'package:antap/models/user.dart';

import 'post.dart';

class VideoPost extends Post {
  final String videoUrl;
  final User postedBy;
  final Review review;
  final String audioName;
  final int favorite;
  final String comments;
  final DateTime postDate;
  final int rate;
  final List<Comment> listComment;

  List getListComment() {
    return listComment;
  }

  int getFavorite() {
    return favorite;
  }

  Review getReview() {
    return review;
  }

  DateTime getDate() {
    return postDate;
  }

  int getRate() {
    return rate;
  }

  VideoPost(this.videoUrl, this.postedBy, this.review, this.audioName,
      this.favorite, this.comments, this.postDate, this.rate, this.listComment);
}
