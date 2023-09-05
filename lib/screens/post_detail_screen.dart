import 'package:antap/models/post.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget Slider(List<String> listImageUrl) {
  int cur = 0;
  return SizedBox(
    width: 500,
    height: 450,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20), 
      child: Image.network(
        listImageUrl[cur],
        fit: BoxFit.contain, 
      ),
    ),
  );
}

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key});
  static String id = "postdetail_screen";

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  int curImage = 0;
  @override
  Widget build(BuildContext context) {
    Post post = Post(
      listImageUrl: [
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
        "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG"
      ],
      coverUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
      review: Review(
        title: "Review quan an 1",
        content: "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."
      ),
      rate: 5,
      postDate: DateTime(2023, 7, 15)
    );
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      curImage = (curImage + 1) % post.listImageUrl.length;
                    });
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: 350,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20), 
                      child: Image.network(
                        post.listImageUrl[curImage],
                        fit: BoxFit.cover, 
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  post.review.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  post.review.content
                ),
                Row(
                  children: List.generate(5, (star) {
                    return Icon(
                      star < post.rate ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                      size: 20
                    );
                  })
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}