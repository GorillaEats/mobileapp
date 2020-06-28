import 'package:flutter/material.dart';
import 'package:gorilla_eats/widgets/search/search.dart';
import 'package:gorilla_eats/widgets/googlemaps.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: [
          GoogleMaps(),
          SafeArea(
            child: Search(),
          )
        ],
      ),
    );
  }
}
