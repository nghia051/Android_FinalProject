import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/data.dart';

class User {
  String email;
  String password;
  String username;
  String profileImageUrl;

  String aboutUser = " ";

  User(
      {required this.email,
      required this.password,
      required this.username,
      required this.profileImageUrl,
      required this.aboutUser});

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'aboutUser': aboutUser,
    };
  }
}

Future<void> getUserDetail() async {
  String? email = await FirebaseAuth.instance.currentUser?.email.toString();
  print('Email: $email');
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
      .instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
  querySnapshot.docs.forEach((doc) {
    final data = doc.data();
    currentUser = User(
        email: data?["email"],
        password: data?["password"],
        username: data?["username"],
        profileImageUrl: data?["profileImageUrl"],
        aboutUser: data?["aboutUser"]);
  });
}
