import 'package:antap/models/image_post.dart';
import 'package:antap/screens/posts/components/post_image_widget.dart';
import 'package:antap/screens/posts/components/post_info_widget.dart';
import 'package:antap/screens/posts/components/post_react_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/data.dart';
import '../../models/post.dart';

String getSubContent(String text, int lim) {
  if (text.length <= lim) {
    return text;
  } else {
    return "${text.substring(0, lim)}...";
  }
}

// Future<List<ImagePost>> getAllPostFromFirestore() async {
//   final postRef = FirebaseFirestore.instance.collection("post").withConverter(
//         fromFirestore: ImagePost.fromFireStore,
//         toFirestore: (ImagePost post, options) => post.toFireStore(),
//       );
//   final querySnapshot = await postRef.get();

//   List<ImagePost> listPost = [];

//   for (var document in querySnapshot.docs) {
//     listPost.add(document.data());
//   }

//   return listPost;
// }

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});
  static String id = "post_screen";

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Column(
        children: List.generate(listImagePost.length, (index) {
          return Container(
            color: Colors.black87,
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
                          listImagePost[index].review.title,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        Text(
                          listImagePost[index].review.content,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        )
                      ]),
                ),
                PostImageWidget(post: listImagePost[index]),
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
