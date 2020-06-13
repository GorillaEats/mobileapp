import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/userlocation.dart';
import '../screens/loading.dart';

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

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      final marker = Marker(
        markerId: MarkerId('initial position'),
        position: _initialPosition,
      );
      _markers[marker.markerId.toString()] = (marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _initialPosition == null
          ? LoadingScreen()
          : GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 15,
              ),
              markers: _markers.values.toSet(),
            ),
    );
  }
}
