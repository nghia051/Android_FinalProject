import 'package:antap/models/user.dart';
import 'package:antap/models/video_post.dart';

import '../models/post.dart';
import '../models/image_post.dart';

User currentUser = User(
  'ttviet2805@gmail.com',
  'ttviet2805',
  'https://picsum.photos/id/1062/400/400',
  'Food critic is a person who explores restaurants and eateries, and introduces it to others. Food critics also review food and dining experiences across different places and share their opinion with their audience.',
);

final List<VideoPost> videos = [
  VideoPost(
    'assets/v1.mp4',
    currentUser,
    DateTime(2023, 7, 15),
    3,
    Review(
        title: "Review quan an 1",
        content: 'Quan an nay kha la ngon, moi nguoi nen thuong thuc no ne.'),
    10,
    [
      Comment(user: currentUser, content: "Ngon vcl"),
      Comment(user: currentUser, content: "Cung duoc"),
    ],
    'audioName',
  ),
  // VideoPost('assets/v2.mp4', currentUser, 'caption', 'audioName', '1.4M', '54k',
  //     DateTime(2023, 7, 15), 3),
  // VideoPost('assets/v3.mp4', currentUser, 'caption', 'audioName', '1k', '30',
  //     DateTime(2023, 7, 15), 3),
  // VideoPost('assets/v4.mp4', currentUser, 'caption', 'audioName', '122', '1',
  //     DateTime(2023, 7, 15), 3),
  // VideoPost('assets/v5.mp4', currentUser, 'caption', 'audioName', '0', '0',
  //     DateTime(2023, 7, 15), 3),
];

List<Post> listPost = [
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
      postedBy: currentUser,
      review: Review(
          title: "Review quan an 1",
          content:
              "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."),
      rate: 5,
      postDate: DateTime(2023, 7, 15),
      favorite: 290903,
      listComment: [
        Comment(user: currentUser, content: "Nghia Viet dan"),
        Comment(user: currentUser, content: "Nghia Viet non"),
      ]),
  VideoPost(
    'assets/v1.mp4',
    currentUser,
    DateTime(2023, 7, 15),
    3,
    Review(
        title: "Review quan an 1",
        content: 'Quan an nay kha la ngon, moi nguoi nen thuong thuc no ne.'),
    10,
    [
      Comment(user: currentUser, content: "Nghia Viet ga"),
      Comment(user: currentUser, content: "Noob tho"),
    ],
    'audioName',
  ),
];

List<ImagePost> listImagePost = [
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
      postedBy: currentUser,
      review: Review(
          title: "Review quan an 1",
          content:
              "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."),
      rate: 5,
      postDate: DateTime(2023, 7, 15),
      favorite: 290903,
      listComment: [
        Comment(user: currentUser, content: "Nghia Viet dan"),
        Comment(user: currentUser, content: "Nghia Viet non"),
      ]),
  ImagePost(
      listImageUrl: [
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg"
      ],
      coverUrl:
          "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
      postedBy: currentUser,
      review: Review(
          title: "Review quan an 2",
          content:
              "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."),
      rate: 3,
      postDate: DateTime(2023, 7, 15),
      favorite: 23082002,
      listComment: [
        Comment(user: currentUser, content: "Ngon vcl"),
        Comment(user: currentUser, content: "Cung duoc"),
        Comment(user: currentUser, content: "Mlem mlem"),
        Comment(user: currentUser, content: "Ha ha ha"),
        Comment(
            user: currentUser,
            content: "Abc zyx dsadjsajd uuuu uwu u u ngon ngon"),
      ])
];
