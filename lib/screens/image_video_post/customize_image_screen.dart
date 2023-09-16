import 'dart:io';

import 'package:antap/constants.dart';
import 'package:antap/screens/image_video_post/customize_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart' as lot;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:uuid/uuid.dart';


class CustomizeImageScreen extends StatefulWidget{
  const CustomizeImageScreen({Key? key}) : super(key: key);
  static String id = 'customize_image_screen';
  @override
  State<CustomizeImageScreen> createState() => _CustomizeImageScreenState();
}

class _CustomizeImageScreenState extends State<CustomizeImageScreen> {
  // Attribute of image post
  String? id;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  List<File?> listImageFiles = [];
  int rating = 1;

  final ImagePicker _picker = ImagePicker();
  Color? buttonColor = Colors.grey;
  List<XFile?> listImages = [];
  String imageUrl = "";

  @override
  void initState(){
    super.initState();
    _titleController.addListener(updateButtonColor);
    _contentController.addListener(updateButtonColor);
    id = Uuid().v1();
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

  void updateButtonColor(){
    setState(() {
      if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty){
        buttonColor = kTextColor;
      } else {
        buttonColor = Colors.grey;
      }
    });
  }

  _save() async {
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty && rating >= 1){
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
        rating = 1;
        listImageFiles.clear();
        listImages.clear();
      });
    }
  }

  @override
  Widget build(context) {
    updateButtonColor();
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, CustomizeScreen.id);
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