import 'package:antap/models/post.dart';
import 'package:antap/screens/map/pop_up/widgets/video_app.dart';
import 'package:antap/screens/posts/components/post_image_widget.dart';
import 'package:antap/screens/posts/components/post_info_widget.dart';
import 'package:antap/screens/posts/components/post_react_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../data/data.dart';

String getSubContent(String text, int lim) {
  if (text.length <= lim) {
    return text;
  } else {
    return "${text.substring(0, lim)}...";
  }
}

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});
  static String id = "new_post_screen";

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: List.generate(
              listPost.length,
              (index) {
                return Container(
                  color: Colors.black87,
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                                listPost[index].getReview().title,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              Text(
                                listPost[index].getReview().content,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )
                            ]),
                      ),
                      listPost[index].getImageVideo(),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: PostReactWidget(post: listPost[index]))
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
