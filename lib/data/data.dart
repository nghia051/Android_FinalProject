import 'package:antap/models/user.dart';
import 'package:antap/models/video_post.dart';

import '../models/post.dart';
import '../models/image_post.dart';

User currentUser = User('ttviet2805', 'https://picsum.photos/id/1062/400/400');

final List<VideoPost> videos = [
  VideoPost(
      'assets/v1.mp4', currentUser, 'caption', 'audioName', '12.5k', '123'),
  VideoPost(
      'assets/v2.mp4', currentUser, 'caption', 'audioName', '1.4M', '54k'),
  VideoPost('assets/v3.mp4', currentUser, 'caption', 'audioName', '1k', '30'),
  VideoPost('assets/v4.mp4', currentUser, 'caption', 'audioName', '122', '1'),
  VideoPost('assets/v5.mp4', currentUser, 'caption', 'audioName', '0', '0'),
];

List<ImagePost> listPost = [
  ImagePost(
      listImageUrl: [
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG"
      ],
      coverUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
      review: Review(
          title: "Review quan an 1",
          content:
              "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."),
      rate: 5,
      postDate: DateTime(2023, 7, 15),
      favorite: 290903,
      listComment: [
        Comment(user: "Hoang Viet", content: "Ngon vcl"),
        Comment(user: "Tran Viet", content: "Cung duoc"),
        Comment(user: "Nguyen Hoang", content: "Mlem mlem"),
        Comment(user: "Dinh Tung", content: "Ha ha ha"),
        Comment(
            user: "Trung Nghia",
            content: "Abc zyx dsadjsajd uuuu uwu u u ngon ngon"),
        Comment(user: "Con tho an co", content: "Ngon vcl"),
        Comment(user: "Jack hht", content: "Cung duoc"),
        Comment(user: "Fuck boy nghi phu", content: "Mlem mlem"),
        Comment(user: "Boy Quang Nom", content: "Ha ha ha"),
        Comment(
            user: "Voi Dak Lak",
            content: "Abc zyx dsadjsajd uuuu uwu u u ngon ngon"),
        Comment(user: "Rabbit", content: "Ngon vcl"),
        Comment(user: "Chinh tri gia", content: "Cung duoc"),
        Comment(user: "APCS", content: "Mlem mlem"),
        Comment(user: "HCMUS", content: "Ha ha ha")
      ]),
  ImagePost(
      listImageUrl: [
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg"
      ],
      coverUrl:
          "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
      review: Review(
          title: "Review quan an 2",
          content:
              "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."),
      rate: 3,
      postDate: DateTime(2023, 7, 15),
      favorite: 23082002,
      listComment: [
        Comment(user: "Hoang Viet", content: "Ngon vcl"),
        Comment(user: "Tran Viet", content: "Cung duoc"),
        Comment(user: "Nguyen Hoang", content: "Mlem mlem"),
        Comment(user: "Dinh Tung", content: "Ha ha ha"),
        Comment(
            user: "Trung Nghia",
            content: "Abc zyx dsadjsajd uuuu uwu u u ngon ngon"),
      ])
];
