import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gorilla_eats/data/locations.dart';
import 'package:gorilla_eats/widgets/restaurantcard.dart';

class MapCards extends StatelessWidget {
  final List<Location> locations;

  MapCards({@required this.locations});

  @override
  Widget build(context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        height: 150,
        child: ListView(
          itemExtent: MediaQuery.of(context).size.width * .9,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          scrollDirection: Axis.horizontal,
          children: locations
              .map((location) => RestaurantCard(location: location))
              .toList(),
        ),
      ),
    );
  }
}
