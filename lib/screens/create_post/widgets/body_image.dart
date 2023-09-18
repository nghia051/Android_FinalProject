import 'dart:io';
import 'package:antap/constants.dart';
import 'package:antap/screens/create_post/widgets/textWithFont.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' as lot;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateImagePostScreen extends StatefulWidget {
  String resID;
  CreateImagePostScreen({required this.resID, super.key});
  static String id = "new_post_screen";
  @override
  State<CreateImagePostScreen> createState() => _CreateImagePostScreenState();
}

class _CreateImagePostScreenState extends State<CreateImagePostScreen> {
  int _rating = 1;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<File?> listImageFiles = [];
  Color? buttonColor = Colors.grey;
  List<XFile?> listImages = [];
  String? fileName;
  String imageUrl = "";
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('imagePosts');
  bool choose = false;
  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(updateButtonColor);
    _contentController.addListener(updateButtonColor);
  }

  chooseImage() async {
    listImages.clear();
    List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      listImages.addAll(selectedImages);
    }
    if (listImages.isNotEmpty) {
      for (int i = 0; i < listImages.length; i++) {
        listImageFiles.add(File(listImages[i]!.path));
      }
    }
    setState(() {
      listImageFiles;
    });
  }

  Future<void> _save() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
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

    if (listImageFiles.isEmpty) return;
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    print(listImageFiles);
    List<String> listURL = [];
    for (var _image in listImageFiles) {
      try {
        fileName = _image!.path.split('/').last;
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
          'review': {
            'title': _titleController.text,
            'content': _contentController.text
          },
          'postedBy': userId,
          'postDate': DateTime.now(),
          'rating': _rating,
          'favorite': 0,
          'listComment': [],
          'resID': widget.resID,
        })
        .then((value) => print("Images Added"))
        .catchError((error) => print("Failed to add images: $error"));
    _titleController.clear();
    _contentController.clear();
    setState(() {
      listImages.clear();
      listImageFiles.clear();
    });

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
      _rating = 1;
      listImageFiles.clear();
      listImages.clear();
    });

    // Navigator.pop(context);
  }

  void updateButtonColor() {
    setState(() {
      if (_titleController.text.isNotEmpty &&
          _contentController.text.isNotEmpty) {
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
                    text: 'Please write a review for this restaurant',
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
                    text: 'Update your image here',
                    fontWeight: FontWeight.w600),
                (listImageFiles.isNotEmpty)
                    ? Center(
                        child: SizedBox(
                            height: 40,
                            width: 120,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.deepOrange.shade400,
                              ),
                              onPressed: () {
                                chooseImage();
                              },
                              child: const Text('Add Image'),
                            )),
                      )
                    : SizedBox(),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    if (listImageFiles.isEmpty) {
                      chooseImage();
                    }
                  },
                  child: Center(
                    child: (listImageFiles.isEmpty)
                        ? Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/icons/image_upload.png',
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          )
                        : Container(
                            height: (listImageFiles.length >= 4)
                                ? MediaQuery.of(context).size.width * 0.6
                                : MediaQuery.of(context).size.width * 0.3,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                ),
                                itemCount: listImageFiles.length,
                                itemBuilder: (context, index) {
                                  return Stack(fit: StackFit.expand, children: [
                                    Image.file(listImageFiles[index]!,
                                        fit: BoxFit.cover),
                                    Positioned(
                                      top: 0.2,
                                      right: 0.2,
                                      child: Transform.scale(
                                        scale: 0.7,
                                        child: Container(
                                          color: const Color.fromRGBO(
                                              161, 207, 81, 0.686),
                                          child: IconButton(
                                            onPressed: () {
                                              listImageFiles.removeAt(index);
                                              setState(() {});
                                            },
                                            icon: const Icon(Icons.delete),
                                            color: Colors.red[500],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]);
                                }),
                          ),
                  ),
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
