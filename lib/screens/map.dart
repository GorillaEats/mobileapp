import 'package:flutter/material.dart';
import '../widgets/googlemaps.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMaps(),
    );
  }
}
