import 'package:antap/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:antap/screens/home_screen.dart';
import 'package:antap/screens/login_screen.dart';
import 'package:antap/screens/signup_screen.dart';
import 'package:antap/screens/welcome.dart';
import 'package:antap/screens/customize_screen.dart';
import 'package:antap/screens/customize_image_screen.dart';
import 'package:antap/screens/customize_video_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String address = "";

  @override
  void initState() {
    super.initState();
    _getAndDisplayAddress();
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
    address = '${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
    setState(()  {
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'Ubuntu',
        ),
      )),
      initialRoute: CustomizeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        MapScreen.id: (context) => MapScreen(),
        CustomizeScreen.id:(context) => CustomizeScreen(address: address),
        CustomizeImageScreen.id:(context) => CustomizeImageScreen(),
        CustomizeVideoScreen.id:(context) => CustomizeVideoScreen(),
      },
    );
  }
}
