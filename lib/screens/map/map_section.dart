import 'dart:async';
import 'dart:typed_data';

import 'package:antap/models/restaurant.dart';
import 'package:antap/screens/map/custom_marker_widget.dart';
import 'package:antap/screens/map/pop_up/widgets/appbar.dart';
import 'package:antap/screens/map/pop_up/widgets/body.dart';
import 'package:antap/screens/map/pop_up/widgets/gutter.dart';
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

  static const CameraPosition _hcmusPos = CameraPosition(
    target: LatLng(10.7605, 106.6818),
    zoom: 17,
  );

  // HCMUS
  LatLng _initialPosition = LatLng(10.7628, 106.6825);
  Set<Marker> markers = {};

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) => _onBuildCompleted());
    _setRestaurantMarker();
    setCurrentLocation();
    _getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Image img = Image.network('https://googleflutter.com/sample_image.jpg');
    // return CustomMarkerWidget(img: img);
    return Stack(children: [
      Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          markers: markers,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: _initialPosition,
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
    ]);
  }

  void _getUserLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
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
          body: NewPostScreen(),
        ),
      );
    });
  }

  _setRestaurantMarker() async {
    List<Restaurant> restaurants = getRestaurantList();

    for (int i = 0; i < restaurants.length; i++) {
      BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          'assets/images/restaurants/restaurant${i + 1}.jpg');
      markers.add(Marker(
        markerId: MarkerId(restaurants[i].id),
        infoWindow: InfoWindow(title: restaurants[i].name),
        position: restaurants[i].location,
        onTap: () {
          showWidget(restaurants[i]);
        },
        icon: markerIcon,
      ));
    }
    setState(() {});
  }

  List<Restaurant> getRestaurantList() {
    List<Restaurant> restaurants = [];
    restaurants.add(Restaurant('restaurant1', 'Name 1', 'imageUrl',
        const LatLng(10.764354, 106.682098)));
    restaurants.add(Restaurant('restaurant2', 'Name 2', 'imageUrl',
        const LatLng(10.761160, 106.683385)));
    restaurants.add(Restaurant('restaurant3', 'Name 3', 'imageUrl',
        const LatLng(10.761814, 106.681829)));
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

  Future<void> _onBuildCompleted() async {
    print('It is running');
  }

  Future<Marker> _generateMarkersFromWidgets(
      CustomMarkerWidget markerWidget) async {
    return const Marker(markerId: MarkerId('asdas'));
  }
}
