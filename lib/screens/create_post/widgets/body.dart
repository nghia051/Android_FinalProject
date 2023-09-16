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

import 'package:lottie/lottie.dart' as lot;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  int rating = 1;
  final _contentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<File?> listImageFiles = [];
  Color? buttonColor = Colors.grey;
  List<XFile?> listImages = [];
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
          physics: const BouncingScrollPhysics(),
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
              Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    lot.Lottie.asset(
                      "assets/lotties/animation_lm7l7pxr.json",
                      width: 80,
                    ),
                    RatingBar.builder(
                      initialRating: rating.toDouble(),
                      minRating: 1,
                      itemSize: 30,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) => setState(() {
                        this.rating = rating.toInt();
                        print(this.rating);
                      })
                    )
                  ],
                ),
              ),
              (listImageFiles.isNotEmpty) ? SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepOrange.shade400,
                  ),
                  onPressed: (){
                    chooseImage();
                  },
                  child: const Text('Add Image'),
                )
              ) : SizedBox(),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  if (listImageFiles.isEmpty){
                    chooseImage();
                  }
                },
                child: (listImageFiles.isEmpty) ? Container(
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
                )  
                : Container(
                  height: (listImageFiles.length >= 4) ? MediaQuery.of(context).size.width * 0.7 : MediaQuery.of(context).size.width * 0.35,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: listImageFiles.length,
                    itemBuilder: (context, index){
                      return Stack(
                        fit: StackFit.expand,
                        children:[
                          Image.file(listImageFiles[index]!, fit: BoxFit.cover),
                          Positioned(
                            top: 0.2,
                            right: 0.2,
                            child: Transform.scale(
                              scale: 0.7,
                              child: Container(
                                color: const Color.fromRGBO(161, 207, 81, 0.686),
                                child: IconButton(
                                  onPressed: (){
                                    listImageFiles.removeAt(index);
                                    setState(() {
                                      
                                    });
                                  },
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red[500],
                                ),
                              ),
                            ),
                          ),
                        ] 
                      );
                    }
                  ),
                ),
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
                    hintText: 'Enter review',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  _save();
                },
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
