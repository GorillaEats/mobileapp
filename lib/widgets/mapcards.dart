import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gorilla_eats/data/location.dart';
import 'package:gorilla_eats/data/models/restaurantcard.dart';
import 'package:gorilla_eats/widgets/restaurantcard.dart';
import 'package:provider/provider.dart';

class MapCards extends StatefulWidget {
  final List<Location> locations;

  MapCards({@required this.locations});

  @override
  _MapCardsState createState() => _MapCardsState();
}

class _MapCardsState extends State<MapCards> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    setState(() {
      _scrollController = ScrollController(
        initialScrollOffset: 0.0,
        keepScrollOffset: true,
      );
    });
  }

  void updateScroll(String selected) {
    var idx = 0;

    for (var i = 0; i < widget.locations.length; i++) {
      if (widget.locations[i].id == selected) {
        idx = i;
        break;
      }
    }

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
          (idx * MediaQuery.of(context).size.width * .9),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(context) {
    return Container(
      height: 150,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Consumer<RestaurantCardSelectedModel>(
        builder: (context, restaurantCardSelectedModel, child) {
          updateScroll(restaurantCardSelectedModel.selected);
          return ListView(
            shrinkWrap: true,
            controller: _scrollController,
            itemExtent: MediaQuery.of(context).size.width * .9,
            padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
            scrollDirection: Axis.horizontal,
            children: widget.locations
                .map((location) => RestaurantCard(location: location))
                .toList(),
          );
        },
      ),
    );
  }
}
