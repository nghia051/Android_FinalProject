import 'dart:io';

import 'package:antap/constants.dart';
import 'package:antap/screens/image_video_post/customize_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class CustomizeImageScreen extends StatefulWidget{
  const CustomizeImageScreen({Key? key}) : super(key: key);
  static String id = 'customize_image_screen';
  @override
  State<CustomizeImageScreen> createState() => _CustomizeImageScreenState();
}

class _CustomizeImageScreenState extends State<CustomizeImageScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  Color? buttonColor = Colors.grey;
  XFile? image;
  String imageUrl = "";

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
        _image = File(image!.path);
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
        Navigator.popAndPushNamed(context, CustomizeScreen.id);
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
                onTap: () async {
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