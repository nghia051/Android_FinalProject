import 'package:antap/models/post.dart';
import 'package:antap/screens/posts/post_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String getSubContent(String text, int lim) {
  if (text.length <= lim) {
    return text; 
  } else {
    return "${text.substring(0, lim)}..."; 
  }
}

Future<List<Post>> getAllPostFromFirestore() async {
  final postRef = FirebaseFirestore.instance.collection("post").withConverter(
    fromFirestore: Post.fromFireStore,
    toFirestore: (Post post, options) => post.toFireStore(),
  );
  final querySnapshot = await postRef.get();

  List<Post> listPost = [];

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
    List<Post> listInitPost = [
      Post(
        listImageUrl: [
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG"
        ],
        coverUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
        review: Review(
          title: "Review quan an 1",
          content: "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."
        ),
        rate: 5,
        postDate: DateTime(2023, 7, 15)
      ),
      Post(
        listImageUrl: [
          "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
          "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
          "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg"
        ],
        coverUrl: "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        review: Review(
          title: "Review quan an 2",
          content: "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."
        ),
        rate: 3,
        postDate: DateTime(2023, 7, 15)
      ),
      Post(
        listImageUrl: [
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG"
        ],
        coverUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
        review: Review(
          title: "Review quan an 1",
          content: "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."
        ),
        rate: 5,
        postDate: DateTime(2023, 7, 15)
      ),
      Post(
        listImageUrl: [
          "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
          "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
          "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg"
        ],
        coverUrl: "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        review: Review(
          title: "Review quan an 2",
          content: "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."
        ),
        rate: 3,
        postDate: DateTime(2023, 7, 15)
      ),
      Post(
        listImageUrl: [
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG"
        ],
        coverUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
        review: Review(
          title: "Review quan an 1",
          content: "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."
        ),
        rate: 5,
        postDate: DateTime(2023, 7, 15)
      ),
      Post(
        listImageUrl: [
          "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
          "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
          "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg"
        ],
        coverUrl: "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        review: Review(
          title: "Review quan an 2",
          content: "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."
        ),
        rate: 3,
        postDate: DateTime(2023, 7, 15)
      ),
      Post(
        listImageUrl: [
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG"
        ],
        coverUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/2018_01_Croissant_IMG_0685.JPG/800px-2018_01_Croissant_IMG_0685.JPG",
        review: Review(
          title: "Review quan an 1",
          content: "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."
        ),
        rate: 5,
        postDate: DateTime(2023, 7, 15)
      ),
      Post(
        listImageUrl: [
          "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
          "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
          "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg"
        ],
        coverUrl: "https://media.saigontourist.edu.vn/Media/1_STHCHOME/FolderFunc/202307/Images/tiramisu-la-gi-20230727025024-e.jpg",
        review: Review(
          title: "Review quan an 2",
          content: "Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat. Toi nam nay hon 70 tuoi roi ma toi chua thay quan an nao ngon nhu the nay, phai toi toi danh cho may nhat."
        ),
        rate: 3,
        postDate: DateTime(2023, 7, 15)
      ),
    ];
    return FutureBuilder<List<Post>> (
      future: getAllPostFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              width: 80.0,
              height: 80.0,
              child: CircularProgressIndicator(
                strokeWidth: 6.0, // You can adjust the stroke width as needed
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.hasData) {
            List<Post> listPost = listInitPost;
            return Scaffold(
              body: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(listPost.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => const PostDetailScreen(),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              padding: const EdgeInsets.all(10),
                              height: 140,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(20), 
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20), 
                                      child: Image.network(
                                        listPost[index].coverUrl,
                                        fit: BoxFit.cover, 
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          listPost[index].review.title,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          getSubContent(listPost[index].review.content, 150),
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "Reviewer: ",
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        Row(
                                          children: List.generate(5, (star) {
                                            return Icon(
                                              star < listPost[index].rate ? Icons.star : Icons.star_border,
                                              color: Colors.yellow,
                                              size: 20
                                            );
                                          })
                                        )
                                      ],    
                                    )
                                  )
                                ],
                              )
                            ),
                          );
                        }),
                    ),
                  ),
                ],
              )
            );
          }
          else {
            return const Text('No data available');
          }
        }
      }
    );
  }
}