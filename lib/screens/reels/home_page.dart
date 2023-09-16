import 'package:antap/models/video_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:antap/data/data.dart';
import 'package:antap/screens/reels/widgets/home_side_bar.dart';
import 'package:antap/screens/reels/widgets/video_detail.dart';
import 'package:antap/screens/reels/widgets/video_tile.dart';

Future<List<VideoPost>> getVideoPosts() async {
  List<VideoPost> videoPosts = [];
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('videoPosts').get();

  querySnapshot.docs.forEach((doc) {
    VideoPost videoPost = VideoPost.fromFirestore(doc, null);
    videoPosts.add(videoPost);
  });

  return videoPosts;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isFollowingSelected = true;
  int _snappedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => {
                setState(
                  () {
                    _isFollowingSelected = true;
                  },
                )
              },
              child: Text(
                'Following',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: _isFollowingSelected ? 18 : 15,
                      color: _isFollowingSelected ? Colors.white : Colors.grey,
                    ),
              ),
            ),
            Text(
              '   |   ',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 14, color: Colors.grey),
            ),
            GestureDetector(
              onTap: () => {
                setState(
                  () {
                    _isFollowingSelected = false;
                  },
                )
              },
              child: Text(
                'For You',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: !_isFollowingSelected ? 18 : 15,
                      color: !_isFollowingSelected ? Colors.white : Colors.grey,
                    ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<VideoPost>>(
        future: getVideoPosts(), // Gọi hàm để lấy dữ liệu
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Hiển thị khi đang tải dữ liệu
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<VideoPost> videoPosts = snapshot.data ?? [];
            return PageView.builder(
              onPageChanged: (int page) => {
                setState(() {
                  _snappedPageIndex = page;
                }),
              },
              scrollDirection: Axis.vertical,
              itemCount: videoPosts.length,
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    VideoTile(
                      video: videoPosts[index],
                      currentIndex: index,
                      snappedPageIndex: _snappedPageIndex,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4,
                            child: VideoDetail(
                              video: videoPosts[index],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 2.2,
                            child: HomeSideBar(video: videoPosts[index]),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          }
        }
      )
    );
  }
}
