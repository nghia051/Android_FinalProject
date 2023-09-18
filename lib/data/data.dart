import 'package:antap/models/restaurant.dart';
import 'package:antap/models/user.dart' as USERNOW;
import 'package:antap/models/video_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/post.dart';
import '../models/image_post.dart';

USERNOW.User? currentUser;

Future<void> getUserDetail() async{
  String? email = await FirebaseAuth.instance.currentUser?.email.toString();
  print("HHAHA");
  print(email);
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
  print(querySnapshot.docs.length);
  querySnapshot.docs.forEach((doc) {
    final data = doc.data();
    currentUser = new USERNOW.User(email: data?["email"], password: data?["password"], username: data?["username"], profileImageUrl: data?["profileImageUrl"], aboutUser: "aboutUser");
  });
  print(currentUser);
}

final List<VideoPost> videos = [
  VideoPost(
    '1',
    'assets/v1.mp4',
    "Hoang Nghia Viet",
    DateTime(2023, 7, 15),
    3,
    Review(
        title: "Review quan an 1",
        content: 'Quan an nay kha la ngon, moi nguoi nen thuong thuc no ne.'),
    10,
    [
      Comment(user: "Hoang Nghia Viet", content: "Nghia Viet dan"),
      Comment(user: "Hoang Nghia Viet", content: "Noob tho"),
    ],
    'audioName',
  ),
  // VideoPost('assets/v2.mp4', "Hoang Nghia Viet", 'caption', 'audioName', '1.4M', '54k',
  //     DateTime(2023, 7, 15), 3),
  // VideoPost('assets/v3.mp4', "Hoang Nghia Viet", 'caption', 'audioName', '1k', '30',
  //     DateTime(2023, 7, 15), 3),
  // VideoPost('assets/v4.mp4', "Hoang Nghia Viet", 'caption', 'audioName', '122', '1',
  //     DateTime(2023, 7, 15), 3),
  // VideoPost('assets/v5.mp4', "Hoang Nghia Viet", 'caption', 'audioName', '0', '0',
  //     DateTime(2023, 7, 15), 3),
];

List<Post> listPost = [
  ImagePost(
      id: '2',
      listImageUrl: [
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG"
      ],
      postedBy: "Hoang Nghia Viet",
      review: Review(
          title: "Review quan an 1",
          content:
              "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."),
      rate: 5,
      postDate: DateTime(2023, 7, 15),
      favorite: 290903,
      listComment: [
        Comment(user: "Hoang Nghia Viet", content: "Nghia Viet dan"),
        Comment(user: "Hoang Nghia Viet", content: "Nghia Viet non"),
      ]),
  VideoPost(
    '1',
    'assets/v1.mp4',
    "Hoang Nghia Viet",
    DateTime(2023, 7, 15),
    3,
    Review(
        title: "Review quan an 1",
        content: 'Quan an nay kha la ngon, moi nguoi nen thuong thuc no ne.'),
    10,
    [
      Comment(user: "Hoang Nghia Viet", content: "Nghia Viet dan"),
      Comment(user: "Hoang Nghia Viet", content: "Noob tho"),
    ],
    'audioName',
  ),
];

List<ImagePost> listImagePost = [
  ImagePost(
      id: '2',
      listImageUrl: [
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG"
      ],
      postedBy: "Hoang Nghia Viet",
      review: Review(
          title: "Review quan an 1",
          content:
              "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."),
      rate: 5,
      postDate: DateTime(2023, 7, 15),
      favorite: 290903,
      listComment: [
        Comment(user: "Hoang Nghia Viet", content: "Nghia Viet dan"),
        Comment(user: "Hoang Nghia Viet", content: "Nghia Viet non"),
      ]),
  ImagePost(
      id: '3',
      listImageUrl: [
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg"
      ],
      postedBy: "Hoang Nghia Viet",
      review: Review(
          title: "Review quan an 2",
          content:
              "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."),
      rate: 3,
      postDate: DateTime(2023, 7, 15),
      favorite: 23082002,
      listComment: [
        Comment(user: "Hoang Nghia Viet", content: "Ngon vcl"),
        Comment(user: "Hoang Nghia Viet", content: "Cung duoc"),
        Comment(user: "Hoang Nghia Viet", content: "Mlem mlem"),
        Comment(user: "Hoang Nghia Viet", content: "Ha ha ha"),
        Comment(
            user: "Hoang Nghia Viet",
            content: "Abc zyx dsadjsajd uuuu uwu u u ngon ngon"),
      ])
];

List<Comment> myComment = [
  Comment(user: "Hoang Viet", content: "Ngon lam moi nguoi nen thu"),
  Comment(user: "Hoang Viet", content: "Tuyet voi nhe"),
  Comment(user: "Hoang Viet", content: "Toi da an o day, rat ngon!!!"),
  Comment(user: "Hoang Viet", content: "HNV dep trai"),
  Comment(user: "Hoang Viet", content: "Hmmm I don't know why many people like this restaurant, it is normal in my opinion"),
  Comment(user: "Hoang Viet", content: "He he haha haha"),
  Comment(user: "Hoang Viet", content: "Cung duoc"),
  Comment(user: "Hoang Viet", content: "Tha amazing!!!!!"),
  Comment(user: "Hoang Viet", content: "wow wow")
];