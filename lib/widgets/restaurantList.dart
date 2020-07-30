import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:provider/provider.dart';
import 'package:gorilla_eats/data/locations.dart';
import 'package:gorilla_eats/widgets/search/search.dart';
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
    return FocusWatcher(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider(
          create: (context) => SearchModel(),
          child: Stack(
            children: [
              Search(),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * .9,
                  child: ListView(
                    children: widget.locations
                        .map((location) => Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: RestaurantCard(location: location),
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
