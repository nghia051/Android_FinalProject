import 'package:antap/screens/post_detail_screen.dart';
import 'package:antap/screens/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: PostScreen.id,
      routes: {
        PostScreen.id: (context) => const PostScreen(),
        PostDetailScreen.id: (context) => const PostDetailScreen(),
      },
    );
  }
}
