import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart' as lot;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:antap/models/restaurant.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:cloud_firestore/cloud_firestore.dart';


class CustomizeScreen extends StatefulWidget {
   const CustomizeScreen({Key? key}) : super(key: key);
  static String id = 'customize_screen';
  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {


  String address = "";
  final ImagePicker _picker = ImagePicker();
  File? _image;
  XFile? image;
  String? fileName;
  int rating = 1;
  bool choose = false;

  // Google Map Api
  late GoogleMapController googleMapController;
  late CameraPosition? initialCameraPosition;
  Set<Marker> markers = {};

  // Firebase
  String? id;
  LatLng? latLng;
  String? imageUrl;
  TextEditingController _resNameController = TextEditingController();
  Restaurant? restaurant;
  CollectionReference resData = FirebaseFirestore.instance.collection('restaurants');


  @override
  void initState() {
    super.initState();
    _getAndDisplayAddress();
    id = Uuid().v1();
  }

  @override
  void dispose(){
    super.dispose();
  }

  Future<void> _getAndDisplayAddress() async {
    Position position = await _determinePosition();
    await GetAddressFromLatLong(position);
    setState(() {
      address;
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    address = '${place.street}, ${place.administrativeArea}, ${place.country}';
    latLng = LatLng(position.latitude, position.longitude);
    initialCameraPosition = CameraPosition(target: latLng!, zoom: 14);

    markers.add(Marker(
      markerId: const MarkerId('currentLocation'),
      infoWindow: const InfoWindow(title: 'You'),
      position: LatLng(position.latitude, position.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
    ));

    setState(()  {
    });
  }

  
  chooseImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        fileName = image!.path.split('/').last;
        _image = File(image!.path);
        choose = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        body: SingleChildScrollView(
          child: Column(
            children: [
               InkWell(
                onTap: (){
                  chooseImage();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                  ),
                  height:  MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                    child: (_image == null) ? Image.asset(
                      'assets/images/restaurants/restaurant4.jpg',
                      fit: BoxFit.cover,
                    ) : Image.file(_image!, fit: BoxFit.cover),
                  ),
                ),
               ),
               Padding(
                padding: const EdgeInsets.only(right: 20), 
                child: Container(
                  height: 80,
                  child: Row(
                    children: [
                      lot.Lottie.asset(
                        "assets/lotties/animation_lm7kzx3s.json",
                        width: 80,
                      ),
                      (address == "") ? lot.Lottie.asset(
                        "assets/lotties/animation_lm7jfzas.json",
                        width: MediaQuery.of(context).size.width - 80 - 60,
                      ) : Text(address),
                    ],
                  ),
                ),
              ),
              (address != "") ? Center(
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(75)),
                  height: 150,
                  width: 150,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(75),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      heightFactor: 0.3,
                      widthFactor: 2.5,
                      child: GoogleMap(
                        initialCameraPosition: initialCameraPosition!,
                        markers: markers,
                        zoomControlsEnabled: false,
                        mapType: MapType.normal,
                        onMapCreated: (GoogleMapController controller) {
                          googleMapController = controller;
                        },
                      ),
                    ),
                  ),
                ),
              ) : SizedBox(
                  height: 150,
                  child: lot.Lottie.asset(
                        "assets/lotties/MapLoading.json",
                        width: 200,
                      )
                ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  height: 80,
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      lot.Lottie.asset(
                        "assets/lotties/animation_lm7lv8je.json",
                        width: 50,
                      ),
                      const SizedBox(width: 15),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 30 - 50 - 20,
                        child: TextField(
                          controller: _resNameController,
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
                            hintText: 'Restaurant name',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300, height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepOrange.shade400,
                  ),
                  onPressed: () async{

                    // Upload image to firebase storage
                    if (choose) {
                      final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
                      try {
                        await storage.ref('images/$fileName').putFile(_image!);
                        firebase_storage.Reference ref = storage.ref('images/$fileName');
                        imageUrl = await ref.getDownloadURL();
                        print("Day ne: $imageUrl");
                      } on firebase_core.FirebaseException catch (e) {
                        print(e);
                      }
                    }
                    else{
                        imageUrl = 'https://firebasestorage.googleapis.com/v0/b/antap-ba5f2.appspot.com/o/images%2Frestaurant4.jpg?alt=media&token=66900a9a-42f1-428f-9369-63389d313e49';
                    }
        
                    // Upload restaurant to firebase firestore
                    restaurant = Restaurant(id!, _resNameController.text, imageUrl!, latLng!);
                    await resData.doc('6cNmPHt3fqV1uzd9UslaHq9CGPi1').set({
                        'id': restaurant!.id,
                        'imageUrl' : restaurant!.imageUrl,
                        'name': restaurant!.name,
                        'latitude': restaurant!.location.latitude,
                        'longtitude': restaurant!.location.longitude,
                      },
                      SetOptions(merge: true),
                    ).then((value) => print("Upload to firestore successfully"),);

                    // print
                    await FirebaseFirestore.instance
                    .collection('restaurants')
                    .get()
                    .then((QuerySnapshot querySnapshot) {
                        querySnapshot.docs.forEach((doc) {
                            print(doc["id"]);
                        });
                        print("lay xun dc roi");
                    });
                  },
                  child: Text("Create"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}









