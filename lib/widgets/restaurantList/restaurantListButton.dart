import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gorilla_eats/data/locations.dart';
import 'package:provider/provider.dart';
import 'package:gorilla_eats/data/models/search.dart';

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
          Provider.of<SearchModel>(context, listen: false).updateListView(true);
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
