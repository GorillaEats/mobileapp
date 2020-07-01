import 'package:flutter/material.dart';
import 'package:gorilla_eats/widgets/restaurant_banner.dart';
import 'package:gorilla_eats/widgets/categoryheader.dart';

class RestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          RestaurantBanner(),
          CategoryHeader(),
        ],
      ),
    );
  }
}
