import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/userlocation.dart';
import '../screens/loading.dart';

const double zoomLevel = 15;

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final Map<String, Marker> _markers = {};
  static LatLng _initialPosition;

  @override
  void initState() {
    super.initState();
    getUserLocation().then((position) {
      setState(() {
        _initialPosition = position;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _initialPosition == null
        ? LoadingScreen()
        : GoogleMap(
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: zoomLevel,
            ),
            markers: _markers.values.toSet(),
          );
  }
}
