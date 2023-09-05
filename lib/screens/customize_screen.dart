import 'dart:io';
import 'package:antap/constants.dart';
import 'package:flutter/material.dart';
import 'package:antap/screens/customize_image_screen.dart';
import 'package:antap/screens/customize_video_screen.dart';

class CustomizeScreen extends StatefulWidget {
  CustomizeScreen({Key? key, required this.address});
  String address;
  static String id = 'customize_screen';
  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text(
                        'Create new restaurant at:',
                        style: TextStyle(
                          color: Colors.black, 
                          fontSize: 16.0, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.address ?? "???",
                        style: const TextStyle(
                          color: Colors.black, // Màu chữ
                          fontSize: 16.0, // Kích thước chữ
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
 
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: kTextColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, CustomizeImageScreen.id);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.image_outlined, size: 30), 
                      SizedBox(width: 50),
                      Text(
                        'New Image Post',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50), 
                    backgroundColor:  kTextColor,
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, CustomizeVideoScreen.id);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.video_call_outlined, size: 30,), 
                      SizedBox(width: 50),
                      Text(
                        'New Video Post',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ),
              ),
              
            ],
          )
        ),
      ),
    );
  }
}