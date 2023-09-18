import 'package:antap/data/data.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:antap/models/video_post.dart';

class VideoDetail extends StatelessWidget {
  const VideoDetail({super.key, required this.video});
  final VideoPost video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '@${currentUser!.username}',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '${video.review.title}',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: 1,
          ),
          ExpandableText(
            video.getReview().content,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
            expandText: 'more',
            collapseText: 'less',
            expandOnTextTap: true,
            collapseOnTextTap: true,
            maxLines: 2,
            linkColor: Colors.grey,
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: List.generate(
              5,
              (index) {
                return Icon(
                  (index < video.getRate()) ? Icons.star : Icons.star_border,
                  color: Colors.yellow,
                );
              },
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Icon(
                Icons.music_note,
                size: 15,
                color: Colors.white,
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                height: 20,
                width: MediaQuery.of(context).size.width / 2,
                child: Marquee(
                  text: "${video.audioName}       ",
                  velocity: 15,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
