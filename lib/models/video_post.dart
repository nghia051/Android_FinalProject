import 'package:antap/models/user.dart';
import 'package:flutter/material.dart';

import '../screens/map/pop_up/widgets/video_app.dart';
import 'post.dart';

class VideoPost extends Post {
  final String videoUrl;
  final User postedBy;
  final Review review;
  final String audioName;
  final int favorite;
  final DateTime postDate;
  final int rate;
  final List<Comment> listComment;

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
