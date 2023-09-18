import 'dart:io';

import 'package:antap/models/user.dart';
import 'package:antap/screens/profile/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../components/custom_raised_button.dart';
import '../../data/data.dart';

TextEditingController _editBioController = TextEditingController();
TextEditingController _editDisplayNameController = TextEditingController();

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //User _user = User();
  File? _profileImageFile;
  
  CollectionReference userData =
      FirebaseFirestore.instance.collection('users');
  Future<void> _pickImage() async {
    final selected = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _profileImageFile = File(selected!.path);
    });
  }

  void _clear() {
    setState(() {
      _profileImageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Edit'),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Color.fromRGBO(255, 63, 111, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _profileImageFile != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: FileImage(_profileImageFile!),
                          radius: 60,
                        ),
                        TextButton(
                          child: Icon(Icons.refresh),
                          onPressed: _clear,
                        ),
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: new BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              width: 100,
                              child: Icon(
                                Icons.person,
                                size: 80,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'Select Profile Image',
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _editDisplayNameController
                    ..text = "${currentUser!.username}",
                  onSaved: (String? value) {
                    String? nullableString = value;
                    String regularString = nullableString ?? "";
                    currentUser!.username = regularString;
                  },
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _editBioController..text = "About me",
                  onChanged: (String value) {
                    //_user.bio = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Bio',
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              GestureDetector(
                child: CustomRaisedButton(buttonText: 'Save'),
                onTap: () async {
                  String? fileName;

                  final firebase_storage.FirebaseStorage storage =
                      firebase_storage.FirebaseStorage.instance;
                              fileName = _profileImageFile!.path.split('/').last;
                  String? imageUrl;
                  try {
                    await storage.ref('images/$fileName').putFile(_profileImageFile!);
                    firebase_storage.Reference ref = storage.ref('images/$fileName');
                    imageUrl = await ref.getDownloadURL();
                    print("Day ne: $imageUrl");
                  } on firebase_core.FirebaseException catch (e) {
                    print(e);
                  }

                  String? id = await FirebaseAuth.instance.currentUser?.uid.toString();
                  print(id);

                  await userData.doc(id!).update({'profileImageUrl': imageUrl,'username': _editDisplayNameController.text, 'aboutUser': _editBioController.text })
                      .then((value) => print("User Updated"))
                      .catchError((error) => print("Failed to update user: $error"));;

                  await getUserDetail();

                  setState(() async {
                        _editBioController.clear();
                        _editDisplayNameController.clear();
                        _profileImageFile = null;
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
