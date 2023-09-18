import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_raised_button.dart';
import 'edit_profile_screen.dart';
import 'package:antap/models/user.dart' as USERNOW;

class ProfilePage extends StatefulWidget {
  static String id = "profile_screen";
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  signOutUser() {
  }

  USERNOW.User? user ;
  Future<void> getUserDetail() async {
    String? email = await FirebaseAuth.instance.currentUser?.email.toString();

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    querySnapshot.docs.forEach((doc) {
      user = new USERNOW.User(email: doc["email"], password: doc["password"], username: doc["username"], profileImageUrl: doc["profileImageUrl"], aboutUser: "aboutUser");
    });

  }

  @override
  void initState()  {
    //getUserDetails(authNotifier);
    getUserDetail();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 30, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      signOutUser();
                    },
                    child: Icon(
                      Icons.person_add,
                    ),
                  ),
                ),
              ],
            ),
            1 != null
                ? CircleAvatar(
              radius: 40.0,
              backgroundImage:
              NetworkImage(user!.profileImageUrl),
              backgroundColor: Colors.transparent,
            )
                : Container(
              decoration: new BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              width: 100,
              child: Icon(
                Icons.person,
                size: 70,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            1 != null
                ? Text(
              user!.username,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'MuseoModerno',
                fontWeight: FontWeight.bold,
              ),
            )
                : Text("You don't have a user name"),
            1 != null
                ? Text(
              "authNotifier.userDetails.bio",
              style: TextStyle(fontSize: 15),
            )
                : Text("Food-iee"),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return EditProfile();
                  }),
                );
              },
              child: CustomRaisedButton(buttonText: 'Edit Profile'),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
