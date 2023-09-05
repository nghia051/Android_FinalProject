// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// class CustomizeScr extends StatefulWidget {
//   CustomizeScr({Key? key}) : super(key: key);

//   @override
//   State<CustomizeScr> createState() => _CustomizeScrState();
// }

// class _CustomizeScrState extends State<CustomizeScr> {
//   final ImagePicker _picker = ImagePicker();
//   File? _image;
//   File? _video;
//   VideoPlayerController? _videoPlayerController;
//   String? address;

//   @override
//   void initState() {
//     super.initState();
//     _getAndDisplayAddress();
//   }

//   @override
//   void dispose(){
//     super.dispose();
//   }

//   chooseImage() async {
//     XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null){
//       setState(() {
//         _image = File(image.path);
//       });
//     }
//   }

//   chooseVideo() async {
//     final video = await _picker.pickVideo(source: ImageSource.gallery);
//     _video = File(video!.path);
//         _videoPlayerController = VideoPlayerController.file(_video!)..initialize().then((_) {
//           setState(() {
            
//           });
//           _videoPlayerController!.play();
//         });
//   }

//   Future<void> _getAndDisplayAddress() async {
//     Position position = await _determinePosition();
//     await GetAddressFromLatLong(position);
    
//     setState(() {
//       address;
//     });
//   }

//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
    
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//     } 

//     return await Geolocator.getCurrentPosition();
//   }

//   Future<void> GetAddressFromLatLong(Position position)async {
//     List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
//     print(placemarks);
//     Placemark place = placemarks[0];
//     address = '${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
//     setState(()  {
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 20.0, right: 20.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0), // Bo góc với bán kính 10
//                     border: Border.all(color: Colors.black, width: 2),
//                      // Viền đen
//                   ),
//                   padding: const EdgeInsets.all(10.0), // Khoảng cách giữa viền và chữ bên trong
//                   child: Column(
//                     children: [
//                       const Text(
//                         'Create new restaurant at:',
//                         style: TextStyle(
//                           color: Colors.black, 
//                           fontSize: 16.0, 
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         address!,
//                         style: const TextStyle(
//                           color: Colors.black, // Màu chữ
//                           fontSize: 16.0, // Kích thước chữ
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
 
//               const SizedBox(height: 50),
//               Padding(
//                 padding: const EdgeInsets.only(left: 40.0, right: 40.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size.fromHeight(50),
//                     backgroundColor: (overlap == false)? Colors.orange.shade400 : Colors.orange.shade100,
//                   ),
//                   onPressed: chooseImage,
//                   child: const Row(
//                     children: [
//                       Icon(Icons.image_outlined, size: 30), 
//                       SizedBox(width: 50),
//                       Text(
//                         'New Image Post',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   )
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Padding(
//                 padding: const EdgeInsets.only(left: 40.0, right: 40.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size.fromHeight(50), 
//                     backgroundColor: (overlap == false)? Colors.orange.shade400 : Colors.orange.shade100,
//                   ),
//                   onPressed: chooseVideo,
//                   child: const Row(
//                     children: [
//                       Icon(Icons.video_call_outlined, size: 30,), 
//                       SizedBox(width: 50),
//                       Text(
//                         'New Video Post',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   )
//                 ),
//               ),
              
//             ],
//           )
//         ),
//       ),
//     );
//   }
// }