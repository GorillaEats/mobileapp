import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
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
        body: ChangeNotifierProvider(
          create: (context) => SearchModel(),
          child: Stack(
            children: [
              GoogleMaps(),
              Consumer<SearchModel>(
                builder: (context, searchModel, child) {
                  return Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomRight,
                        child: listButton(searchModel, context),
                      ),
                      if (searchModel.results.isNotEmpty)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: MapCards(locations: searchModel.results),
                        ),
                    ],
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
