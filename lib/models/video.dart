import 'package:antap/models/user.dart';

import 'new_post.dart';

class Video extends NewPost {
  final String videoUrl;
  final User postedBy;
  final String caption;
  final String audioName;
  final String likes;
  final String comments;

  Video(this.videoUrl, this.postedBy, this.caption, this.audioName, this.likes,
      this.comments);
}
