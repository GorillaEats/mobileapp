import 'package:flutter/material.dart';
import 'package:gorilla_eats/widgets/search/search.dart';
import 'package:provider/provider.dart';
import 'package:gorilla_eats/data/locations.dart';
import 'package:gorilla_eats/data/models/search.dart';
import 'package:gorilla_eats/widgets/restaurantcard.dart';

class RestaurantList extends StatefulWidget {
  final List<Location> locations;

  RestaurantList({@required this.locations});

  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        alignment: Alignment.topCenter,
        padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
        child: Center(
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 0,
                child: Column(
                  children: <Widget>[
                    Text(
                      'All Restaurants:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: 350,
                  child: Divider(
                    color: Colors.grey[500],
                    height: 30,
                    thickness: 2,
                  ),
                ),
              ),
              Flexible(
                flex: 8,
                child: Container(
                  width: MediaQuery.of(context).size.width * .9,
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    children: widget.locations
                        .map((location) => Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: RestaurantCard(
                                  location: location, onMap: false),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
