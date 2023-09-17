import 'dart:io';
import 'package:antap/constants.dart';
import 'package:antap/screens/create_post/widgets/textWithFont.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' as lot;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class CreateVideoPostScreen extends StatefulWidget {
  const CreateVideoPostScreen({super.key});
  static String id = "new_post_screen";
  @override
  State<CreateVideoPostScreen> createState() => _CreateVideoPostScreenState();
}

class _CreateVideoPostScreenState extends State<CreateVideoPostScreen> {
  int _rating = 1;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  File? _video;
  final ImagePicker _picker = ImagePicker();
  Color? buttonColor;
  VideoPlayerController? _videoPlayerController;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('videoPosts');
  String? fileName;
  String videoUrl = "";
  bool choose = false;
  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(updateButtonColor);
    _contentController.addListener(updateButtonColor);
  }

  chooseVideo() async {
    final video = await _picker.pickVideo(source: ImageSource.gallery);
    _video = File(video!.path);
    _videoPlayerController = VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController!.play();
      });
  }

  void updateButtonColor() {
    setState(() {
      if (_titleController.text.isNotEmpty &&
          _contentController.text.isNotEmpty &&
          _video != null) {
        buttonColor = kTextColor;
      } else {
        buttonColor = Colors.grey;
      }
    });
  }

  Future<void> _save() async {
    if (_titleController.text.isEmpty ||
        _contentController.text.isEmpty ||
        _video == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Wrong Input"),
            content: Text("Please enter all field"),
          );
        },
      );
      return;
    }

    if (_video == null) return;

    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    print(_video);
    try {
      fileName = _video!.path.split('/').last;
      await storage.ref('videoPosts/$fileName').putFile(_video!);
      firebase_storage.Reference ref = storage.ref('videoPosts/$fileName');
      videoUrl = await ref.getDownloadURL();
      print("Day ne: $videoUrl");
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }

    String? userId = await FirebaseAuth.instance.currentUser?.uid.toString();

    await collectionReference
        .add({
          'videoUrl': videoUrl,
          'postedBy': userId,
          'postDate': DateTime.now(),
          'rating': _rating,
          'review': {_titleController.text, _contentController.text},
          'favorite': 0,
          'listComment': [],
          'audioName': 'Perfect',
        })
        .then((value) => print("VideoPost Added"))
        .catchError((error) => print("Failed to add video post: $error"));

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Post Successfully"),
            content: Text("You can view it now"),
          );
        });

    _titleController.clear();
    _contentController.clear();
    setState(() {
      _rating = 1;
      _video = null;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(context) {
    updateButtonColor();
    return WillPopScope(
      onWillPop: () async {
        //Navigator.popAndPushNamed(context, CustomizeScreen.id);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWithFont().textWithRobotoFont(
                    color: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .color!
                        .withOpacity(.6),
                    fontSize: 14.sp,
                    text: 'Post a video review for this restaurant',
                    fontWeight: FontWeight.w500),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      lot.Lottie.asset(
                        "assets/lotties/animation_lm7l7pxr.json",
                        height: 80,
                      ),
                      RatingBar.builder(
                          initialRating: _rating.toDouble(),
                          minRating: 1,
                          itemSize: 30,
                          itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                          onRatingUpdate: (rating) => setState(() {
                                this._rating = rating.toInt();
                                print(this._rating);
                              }))
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                TextWithFont().textWithRobotoFont(
                    color: Theme.of(context).textTheme.headline1!.color!,
                    fontSize: 14.sp,
                    text: 'Review Title',
                    fontWeight: FontWeight.w600),
                Form(
                  child: TextFormField(
                    controller: _titleController,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      fillColor: authTextFromFieldFillColor.withOpacity(.3),
                      hintText: 'Enter your review title here',
                      hintStyle: TextStyle(
                        color: authTextFromFieldHintTextColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: authTextFromFieldPorderColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: authTextFromFieldPorderColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextWithFont().textWithRobotoFont(
                    color: Theme.of(context).textTheme.headline1!.color!,
                    fontSize: 14.sp,
                    text: 'Update your video here',
                    fontWeight: FontWeight.w600),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    chooseVideo();
                  },
                  child: (_video == null)
                      ? Center(
                          child: Container(
                            width:
                                80.0, // Điều chỉnh kích thước bên trong container theo ý muốn
                            height:
                                80.0, // Điều chỉnh kích thước bên trong container theo ý muốn
                            decoration: BoxDecoration(
                              shape: BoxShape
                                  .circle, // Tạo hình tròn cho container
                              border: Border.all(
                                  color: Colors.black, width: 2.0), // Viền đen
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/icons/video_upload.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: _videoPlayerController!.value.isInitialized
                              ? AspectRatio(
                                  aspectRatio:
                                      _videoPlayerController!.value.aspectRatio,
                                  child: VideoPlayer(_videoPlayerController!),
                                )
                              : Container(),
                        ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextWithFont().textWithRobotoFont(
                    color: Theme.of(context).textTheme.headline1!.color!,
                    fontSize: 14.sp,
                    text: 'Write Your Review',
                    fontWeight: FontWeight.w600),
                Form(
                  child: TextFormField(
                    controller: _contentController,
                    minLines: 4,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      fillColor: authTextFromFieldFillColor.withOpacity(.3),
                      hintText: 'Write your review here',
                      hintStyle: TextStyle(
                        color: authTextFromFieldHintTextColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: authTextFromFieldPorderColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: authTextFromFieldPorderColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.pink,
                        side: BorderSide.none,
                        // primary:,
                        minimumSize: Size(120.w, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: TextWithFont().textWithRobotoFont(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        text: 'Save',
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
