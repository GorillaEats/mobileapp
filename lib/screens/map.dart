import 'package:flutter/material.dart';
import 'package:gorilla_eats/widgets/mapcards.dart';
import '../widgets/googlemaps.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMaps(),
          MapCards(),
        ],
      ),
    );
  }
}
