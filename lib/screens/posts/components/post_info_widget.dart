import 'package:antap/models/image_post.dart';
import 'package:flutter/material.dart';

import '../../../models/post.dart';

class PostInfoWidget extends StatefulWidget {
  final Post post;
  const PostInfoWidget({required this.post, super.key});

  @override
  State<PostInfoWidget> createState() => _PostInfoWidgetState();
}

class _PostInfoWidgetState extends State<PostInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.account_circle_outlined,
          size: 40,
          color: Colors.white,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("UserXXX",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            Text(widget.post.getDate().toString(),
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey))
          ],
        ),
        const Expanded(child: SizedBox()),
        Row(
            children: List.generate(5, (index) {
          return Icon(
            (index < widget.post.getRate()) ? Icons.star : Icons.star_border,
            color: Colors.yellow,
          );
        }))
      ],
    );
  }
}
