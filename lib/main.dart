import 'package:antap/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:antap/screens/auth/home_screen.dart';
import 'package:antap/screens/auth/login_screen.dart';
import 'package:antap/screens/auth/signup_screen.dart';
import 'package:antap/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontFamily: 'Ubuntu',
            ),
          )),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        MainScreen.id: (context) => MainScreen(),
      },
    );
  }
}