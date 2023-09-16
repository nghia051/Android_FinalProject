import 'dart:io';
import 'package:antap/constants.dart';
import 'package:antap/models/post.dart';
import 'package:antap/screens/create_post/widgets/textWithFont.dart';
import 'package:antap/screens/map/pop_up/widgets/video_app.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:antap/data/data.dart';

import 'package:lottie/lottie.dart' as lot;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});
  static String id = "new_post_screen";
  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  double _rating = 1;
  final _contentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<File?> listImageFiles = [];
  Color? buttonColor = Colors.grey;
  List<XFile?> listImages = [];
  String? fileName;
  String imageUrl = "";
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('imagePost');
  bool choose =  false;
  IconData? _selectedIcon;


  @override
  void initState(){
    super.initState();
    _titleController.addListener(updateButtonColor);
    _contentController.addListener(updateButtonColor);
  }

  chooseImage() async {
    listImages.clear();
    List<XFile>? selectedImages =  await _picker.pickMultiImage();
    if (selectedImages.isNotEmpty){
      listImages.addAll(selectedImages);
    }
    if (listImages.isNotEmpty){
      for (int i = 0; i < listImages.length; i++){
        listImageFiles.add(File(listImages[i]!.path));
      }
    }
    setState(() {
      listImageFiles;
    });
  }

  Future<void> _save() async {
    if(listImageFiles.isEmpty) return ;
    final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
    List<String> listURL = [];
    for(var _image in listImageFiles)
      {
        try {
          await storage.ref('imagePosts/$fileName').putFile(_image!);
          firebase_storage.Reference ref = storage.ref('imagePosts/$fileName');
          imageUrl = await ref.getDownloadURL();
          print("Day ne: $imageUrl");
          listURL.add(imageUrl);
        } on firebase_core.FirebaseException catch (e) {
          print(e);
        }
      }
    String? userId = await FirebaseAuth.instance.currentUser?.uid.toString();

    await collectionReference
        .add({
      'listImageURL': listURL,
      'title': _titleController.text,
      'content': _contentController.text,
      'postedBy': userId,
      'postDate': DateTime.now(),
      'rating' : 5
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Post Successfully"),
            content: Text("You can view it now"),
          );
        },
      );

      _titleController.clear();
      _contentController.clear();
      setState(() {
        listURL.clear();
      });
    }

  }



  void updateButtonColor(){
    setState(() {
      if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty){
        buttonColor = kTextColor;
      } else {
        buttonColor = Colors.grey;
      }
    });
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                TextWithFont().textWithRobotoFont(
                    color: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .color!
                        .withOpacity(.6),
                    fontSize: 14.sp,
                    text:
                    'Please write a review for this restaurant',
                    fontWeight: FontWeight.w500),
                SizedBox(
                  height: 20.h,
                ),
                RatingBar.builder(
                  glowColor: Colors.grey.shade500,
                  initialRating: _rating,
                  minRating: 1,
                  direction:Axis.horizontal,
                  allowHalfRating: true,
                  unratedColor: Colors.amber.withAlpha(50),
                  itemCount: 5,
                  itemSize: 40.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    _selectedIcon ?? Icons.star,
                    color: Color.fromRGBO(245, 201, 99, 1),
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                  updateOnDrag: true,
            ),
                SizedBox(
                  height: 40.h,
                ),
                TextWithFont().textWithRobotoFont(
                    color: Theme.of(context).textTheme.headline1!.color!,
                    fontSize: 14.sp,
                    text: 'Write Your Review',
                    fontWeight: FontWeight.w600),
                SizedBox(
                  height: 8.h,
                ),
                Form(
                  child: TextFormField(
                    controller: _contentController,
                    minLines: 6,
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
                        borderSide:
                        const BorderSide(color: authTextFromFieldPorderColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: authTextFromFieldPorderColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
               Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.white,
                          side: BorderSide.none,
                          // primary:,
                          minimumSize: Size(120.w, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: TextWithFont().textWithRobotoFont(
                          color: Colors.white,
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
