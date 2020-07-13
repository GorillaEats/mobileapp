import 'package:flutter/material.dart';
import 'package:gorilla_eats/data/locations.dart';
import 'package:gorilla_eats/widgets/restaurant_banner.dart';
import 'package:gorilla_eats/widgets/categories.dart';

class RestaurantScreen extends StatelessWidget {
  final Location location;

  RestaurantScreen({this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          RestaurantBanner(location: location),
          Categories(),
        ],
      ),
    );
  }
}
