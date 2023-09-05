import '../models/user.dart';
import '../models/video.dart';

User currentUser = User('ttviet2805', 'https://picsum.photos/id/1062/400/400');

final List<Video> videos = [
  Video('assets/v1.mp4', currentUser, 'caption', 'audioName', '12.5k', '123'),
  Video('assets/v2.mp4', currentUser, 'caption', 'audioName', '1.4M', '54k'),
  Video('assets/v3.mp4', currentUser, 'caption', 'audioName', '1k', '30'),
  Video('assets/v4.mp4', currentUser, 'caption', 'audioName', '122', '1'),
  Video('assets/v5.mp4', currentUser, 'caption', 'audioName', '0', '0'),
];
