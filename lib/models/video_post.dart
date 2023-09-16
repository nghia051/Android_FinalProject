import 'package:antap/models/user.dart';
import 'package:flutter/material.dart';

import '../screens/map/pop_up/widgets/video_app.dart';
import 'post.dart';

class VideoPost extends Post {
  String id;
  String videoUrl;
  User postedBy;
  DateTime postDate;
  int rate;
  Review review;
  int favorite;
  List<Comment> listComment;
  String audioName;

  VideoPost(this.id, this.videoUrl, this.postedBy, this.postDate, this.rate,
      this.review, this.favorite, this.listComment, this.audioName);

  @override
  String getID() {
    return id;
  }

  @override
  Widget getImageVideo() {
    return VideoPlayerScreen(
      video: this,
    );
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

  @override
  void updateFavorite(int val) {
    favorite += val;
  }

  @override
  void updateComment(Comment comment) {
    listComment.add(comment);
  }
}
