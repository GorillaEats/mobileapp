import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gorilla_eats/data/locations.dart';
import 'package:gorilla_eats/data/userlocation.dart';
import 'package:gorilla_eats/screens/loading.dart';
import 'package:gorilla_eats/widgets/mapcards.dart';

const double zoomLevel = 15;

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final Map<String, Marker> _markers = {};
  static LatLng _initialPosition;
  static List<Location> _nearbyLocations = [];

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
    final nearbyLocations = await Location.getNearbyLocations();
    setState(() {
      _markers.clear();
      _nearbyLocations = nearbyLocations;
      for (final location in nearbyLocations) {
        final marker = Marker(
          markerId: MarkerId(location.address),
          position: LatLng(location.lat, location.lng),
        );
        _markers[location.address] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _initialPosition == null
            ? LoadingScreen()
            : Stack(
                children: <Widget>[
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: zoomLevel,
                    ),
                    markers: _markers.values.toSet(),
                  ),
                  if (_nearbyLocations.isNotEmpty)
                    MapCards(locations: _nearbyLocations),
                ],
              ));
  }
}
