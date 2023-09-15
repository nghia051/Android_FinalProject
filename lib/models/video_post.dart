import 'package:antap/models/user.dart';
import 'package:flutter/material.dart';

import '../screens/map/pop_up/widgets/video_app.dart';
import 'post.dart';

class VideoPost extends Post {
  String videoUrl;
  User postedBy;
  Review review;
  String audioName;
  int favorite;
  DateTime postDate;
  int rate;
  List<Comment> listComment;

  Widget getImageVideo() {
    return VideoPlayerScreen(
      video: this,
    );
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

  VideoPost(this.videoUrl, this.postedBy, this.review, this.audioName,
      this.favorite, this.postDate, this.rate, this.listComment);
}
