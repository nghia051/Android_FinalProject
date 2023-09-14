import 'package:antap/models/image_post.dart';
import 'package:flutter/material.dart';

class PostCommentWidget extends StatefulWidget {
  final ImagePost post;
  const PostCommentWidget({required this.post, super.key});

  @override
  State<PostCommentWidget> createState() => _PostCommentWidgetState();
}

class _PostCommentWidgetState extends State<PostCommentWidget> {
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
                itemCount: widget.post.listComment.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.account_circle_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.post.listComment[index].user,
                                  style: const TextStyle(color: Colors.white)),
                              Text(widget.post.listComment[index].content,
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
              child: const Row(
                children: [
                  Icon(
                    Icons.account_circle_outlined,
                    size: 40,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Viết bình luận...',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
