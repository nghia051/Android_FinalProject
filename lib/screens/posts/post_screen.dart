import 'package:antap/models/image_post.dart';
import 'package:antap/screens/posts/components/post_image_widget.dart';
import 'package:antap/screens/posts/components/post_info_widget.dart';
import 'package:antap/screens/posts/components/post_react_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/post.dart';

String getSubContent(String text, int lim) {
  if (text.length <= lim) {
    return text;
  } else {
    return "${text.substring(0, lim)}...";
  }
}

Future<List<ImagePost>> getAllPostFromFirestore() async {
  final postRef = FirebaseFirestore.instance.collection("post").withConverter(
        fromFirestore: ImagePost.fromFireStore,
        toFirestore: (ImagePost post, options) => post.toFireStore(),
      );
  final querySnapshot = await postRef.get();

  List<ImagePost> listPost = [];

  for (var document in querySnapshot.docs) {
    listPost.add(document.data());
  }

  return listPost;
}

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});
  static String id = "post_screen";

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
        body: ListView(children: [
      Column(
        children: List.generate(listPost.length, (index) {
          return Container(
            color: Colors.black54,
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PostInfoWidget(post: listPost[index]),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          listPost[index].review.title,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        Text(
                          listPost[index].review.content,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        )
                      ]),
                ),
                PostImageWidget(post: listPost[index]),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: PostReactWidget(post: listPost[index]))
              ],
            ),
          );
        }),
      )
    ]));
  }
}
