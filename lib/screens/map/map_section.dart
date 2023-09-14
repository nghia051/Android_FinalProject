import 'dart:async';

import 'package:antap/models/restaurant.dart';
import 'package:antap/src/appbar.dart';
import 'package:antap/src/card.dart';
import 'package:antap/src/gutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:antap/screens/map/pop_up/popup_screen.dart';

class MapSection extends StatefulWidget {
  const MapSection({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MapSectionState();
  }
}

class _MapSectionState extends State<MapSection> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // APP BAR
  //
  // [XenCardAppBar]
  XenCardAppBar appBar = const XenCardAppBar(
    child: Text(
      "app bar",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
    ),
    // To remove shadow from appbar
    shadow: BoxShadow(color: Colors.transparent),
  );

  // GUTTER
  //
  // [XenCardGutter]
  XenCardGutter gutter = const XenCardGutter(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: CustomButton(text: "close"),
    ),
  );

  static const CameraPosition _hcmusPos = CameraPosition(
    target: LatLng(10.7605, 106.6818),
    zoom: 17,
  );

  Widget? restaurantInfoWindow;

  // kGooglePlex
  LatLng currentPosition = const LatLng(37.42796133580664, -122.085749655962);
  Set<Marker> markers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // currentPosition = const LatLng(37.42796133580664, -122.085749655962);
    // _getUserLocation();
    setRestaurantMarker();
    setCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          markers: markers,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: currentPosition,
            zoom: 17,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: setCurrentLocation,
          label: const Text("Now"),
          icon: const Icon(Icons.location_history),
        ),
      ),
      if (restaurantInfoWindow != null) restaurantInfoWindow!,
    ]);
  }

  void _getUserLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> setCurrentLocation() async {
    Position position = await _determinePosition();
    final c = await _controller.future;
    c.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 17)));

    if (markers.isNotEmpty &&
        markers.last.markerId == const MarkerId('currentLocation')) {
      markers.remove(markers.last);
    }

    markers.add(Marker(
      markerId: const MarkerId('currentLocation'),
      infoWindow: const InfoWindow(title: 'You'),
      position: LatLng(position.latitude, position.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue,
      ),
    ));

    setState(() {});
  }

  void showWidget(Restaurant restaurant) {
    setState(() {
      showDialog(
        context: context,
        builder: (builder) => XenPopupCard(
          appBar: appBar,
          gutter: gutter,
          body: ListView(
            children: const [
              Text("body"),
            ],
          ),
        ),
      );
    });
  }

  void setRestaurantMarker() {
    List<Restaurant> restaurants = getRestaurantList();

    for (int i = 0; i < restaurants.length; i++) {
      markers.add(Marker(
          markerId: MarkerId(restaurants[i].id),
          infoWindow: InfoWindow(title: restaurants[i].name),
          position: restaurants[i].location,
          onTap: () {
            showWidget(restaurants[i]);
          },
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          )));
    }
    setState(() {});
  }

  List<Restaurant> getRestaurantList() {
    List<Restaurant> restaurants = [];
    restaurants.add(Restaurant(
        'restaurant1', 'Name 1', const LatLng(10.764354, 106.682098)));
    restaurants.add(Restaurant(
        'restaurant2', 'Name 2', const LatLng(10.761160, 106.683385)));
    restaurants.add(Restaurant(
        'restaurant3', 'Name 3', const LatLng(10.761814, 106.681829)));
    return restaurants;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
