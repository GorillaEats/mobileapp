import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gorilla_eats/data/locations.dart';
import 'package:gorilla_eats/screens/restaurantList.dart';

Widget restaurantListButton(
    BuildContext context, List<Location> _nearbyLocations) {
  return Container(
    alignment: Alignment.bottomRight,
    padding: EdgeInsets.fromLTRB(0, 0, 10, 170),
    child: SizedBox(
      height: 60,
      width: 60,
      child: RaisedButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => RestaurantList(locations: _nearbyLocations),
            ),
          );
        },
        child: Center(
          child: Icon(
            Icons.format_list_bulleted,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}
