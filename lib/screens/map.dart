import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:gorilla_eats/data/models/restaurantcard.dart';
import 'package:provider/provider.dart';
import 'package:gorilla_eats/widgets/search/search.dart';
import 'package:gorilla_eats/data/models/search.dart';
import 'package:gorilla_eats/widgets/googlemaps.dart';
import 'package:gorilla_eats/widgets/listButton.dart';
import 'package:gorilla_eats/widgets/mapcards.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider<SearchModel>(create: (_) => SearchModel()),
            ChangeNotifierProvider<RestaurantCardSelectedModel>(
              create: (_) => RestaurantCardSelectedModel(),
            )
          ],
          child: Stack(
            children: [
              GoogleMaps(),
              Consumer<SearchModel>(
                builder: (context, searchModel, child) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: listButton(searchModel, context),
                        ),
                        if (searchModel.results.isNotEmpty)
                          MapCards(locations: searchModel.results),
                      ],
                    ),
                  );
                },
              ),
              Search(),
            ],
          ),
        ),
      ),
    );
  }
}
