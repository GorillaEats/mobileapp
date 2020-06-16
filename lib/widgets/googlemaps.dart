import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/locations.dart';
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
  static LatLng _searchPosition;

  @override
  void initState() {
    super.initState();
    getUserLocation().then((position) {
      setState(() {
        _initialPosition = position;
        _searchPosition = position;
      });
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final nearbyLocations = await getNearbyLocations();
    setState(() {
      _markers.clear();
      for (final location in nearbyLocations) {
        final marker = Marker(
          markerId: MarkerId(location.address),
          position: LatLng(location.lat, location.lng),
          infoWindow: InfoWindow(
            title: location.name,
            snippet: location.address,
          ),
        );
        _markers[location.address] = marker;
      }
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
                zoom: zoomLevel,
              ),
              markers: _markers.values.toSet(),
            ),
    );
  }
}
