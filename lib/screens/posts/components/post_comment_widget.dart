import 'package:antap/data/data.dart';
import 'package:antap/models/image_post.dart';
import 'package:flutter/material.dart';

import '../../../models/post.dart';

class PostCommentWidget extends StatefulWidget {
  final Post post;
  const PostCommentWidget({required this.post, super.key});

  @override
  State<PostCommentWidget> createState() => _PostCommentWidgetState();
}

class _PostCommentWidgetState extends State<PostCommentWidget> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0, // Tắt độ bóng của dialog
      backgroundColor: Colors.black,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Bình luận', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.post.getListComment().length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.post
                              .getListComment()[index]
                              .user
                              .profileImageUrl),
                          radius: 17,
                          // size: 40,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.post
                                    .getListComment()[index]
                                    .user
                                    .username,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(widget.post.getListComment()[index].content,
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              color: Colors.grey[800],
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              width: double.infinity,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(currentUser.profileImageUrl),
                    radius: 17,
                    // size: 40,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Viết bình luận...',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    )
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ), 
                    onPressed: () {
                      setState(() {
                        widget.post.updateComment(Comment(user: "Hoang Nghia Viet", content: _controller.text));
                        _controller.clear();
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
