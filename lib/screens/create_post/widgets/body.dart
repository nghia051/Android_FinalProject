import 'dart:io';
import 'package:antap/constants.dart';
import 'package:antap/models/post.dart';
import 'package:antap/screens/map/pop_up/widgets/video_app.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:antap/data/data.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';


class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});
  static String id = "new_post_screen";

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  Color? buttonColor = Colors.grey;
  XFile? image;
  String? fileName;
  String imageUrl = "";
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('imagePost');
  bool choose =  false;

  @override
  void initState(){
    super.initState();
    _titleController.addListener(updateButtonColor);
    _contentController.addListener(updateButtonColor);
  }

  chooseImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        fileName = image!.path.split('/').last;
        _image = File(image!.path);
        choose = true;
      });
    }
  }

  Future<void> addImagePost() async {
    if (choose) {
      final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
      try {
        await storage.ref('imagePosts/$fileName').putFile(_image!);
        firebase_storage.Reference ref = storage.ref('imagePosts/$fileName');
        imageUrl = await ref.getDownloadURL();
        print("Day ne: $imageUrl");
      } on firebase_core.FirebaseException catch (e) {
        print(e);
      }
    }
    else{
      imageUrl = 'https://firebasestorage.googleapis.com/v0/b/antap-ba5f2.appspot.com/o/images%2Frestaurant4.jpg?alt=media&token=66900a9a-42f1-428f-9369-63389d313e49';
    }
    String? userId = await FirebaseAuth.instance.currentUser?.uid.toString();

    await collectionReference
        .add({
      'listImageURL': [imageUrl],
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
        _image = null;
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
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text("Create Post", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    hintText: 'Enter title',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  chooseImage();
                },
                child: (_image == null) ? Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                            child: Image.asset(
                              'assets/images/icons/image_upload.png',
                              fit: BoxFit.cover,
                            ),
                          )
                  ),
                ) : Image.file(_image!),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  autofocus: false,
                  keyboardType: TextInputType.multiline,
                  controller: _contentController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    hintText: 'Enter comment',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: addImagePost,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), 
                  decoration: BoxDecoration(
                    color: buttonColor, 
                    borderRadius: BorderRadius.circular(5), 
                    border: Border.all(color: Colors.black), 
                  ),
                  child: const Text(
                    'POST',
                    style: TextStyle(
                      color: Colors.white, // Màu chữ
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
