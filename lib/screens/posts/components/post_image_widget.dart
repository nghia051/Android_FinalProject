import 'package:antap/models/image_post.dart';
import 'package:flutter/material.dart';

class PostImageWidget extends StatefulWidget {
  final ImagePost post;
  int curImage = 0;

  PostImageWidget({required this.post, super.key});

  @override
  State<PostImageWidget> createState() => _PostImageWidgetState();
}

class _PostImageWidgetState extends State<PostImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center, // Đặt hình ảnh và nút chính giữa
      children: [
        Image.network(
          widget.post.listImageUrl[widget.curImage],
          height: 300,
          fit: BoxFit.cover, // Đặt cách hiển thị hình ảnh
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_left,
                size: 50,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  widget.curImage =
                      (widget.curImage - 1 + widget.post.listImageUrl.length) %
                          widget.post.listImageUrl.length;
                });
              },
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_right,
                size: 50,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  widget.curImage =
                      (widget.curImage + 1) % widget.post.listImageUrl.length;
                });
              },
            ),
          ],
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
            decoration: BoxDecoration(
              color: Colors.black, // Đặt màu nền đen
              borderRadius: BorderRadius.circular(10.0), // Độ bo góc
            ),
            child: Text(
                "${widget.curImage + 1}/${widget.post.listImageUrl.length}",
                style: const TextStyle(
                  color: Colors.white,
                )),
          ),
        )
      ],
    );
  }
}
