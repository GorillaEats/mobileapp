import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gorilla_eats/data/locations.dart';
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
  var locationCards = <RestaurantCard>[];

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

  void updateScroll(int idx) {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
          (idx * MediaQuery.of(context).size.width * .9),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut);
    }
  }

  void getLocationCards() {
    setState(() {
      for (var i = 0; i < widget.locations.length; i++) {
        locationCards
            .add(RestaurantCard(location: widget.locations[i], idx: i));
      }
    });
  }

  @override
  Widget build(context) {
    getLocationCards();

    return Consumer<RestaurantCardSelectedModel>(
      builder: (context, restaurantCardSelectedModel, child) {
        updateScroll(restaurantCardSelectedModel.selectedIdx);
        return Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          height: 150,
          child: ListView(
            controller: _scrollController,
            itemExtent: MediaQuery.of(context).size.width * .9,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            scrollDirection: Axis.horizontal,
            children: locationCards,
          ),
        );
      },
    );
  }
}
