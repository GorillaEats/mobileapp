import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, Marker> _markers = {};
  static LatLng _initialPosition;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      final marker = Marker(
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (context) {
                return Container(
                  height: 200,
                  color: Colors.amber
                );
              }
            );
          },
          markerId: MarkerId('initial position test'),
          position: _initialPosition,
        );
        _markers[marker.markerId.toString()] = (marker);
    });
  }

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Gorilla Eats Map'),
          backgroundColor: Colors.red[400],
        ),
        body: _initialPosition == null
            ? Container(
                child: Center(
                  child: Text(
                    'loading map..',
                    style: TextStyle(
                        fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
                  ),
                ),
              )
            : GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 10,
                ),
                markers: _markers.values.toSet(),
              ),
      ),
    );
  }
}