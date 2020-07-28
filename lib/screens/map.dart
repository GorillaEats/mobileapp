import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:provider/provider.dart';
import 'package:gorilla_eats/widgets/search/search.dart';
import 'package:gorilla_eats/widgets/googlemaps.dart';
import 'package:gorilla_eats/data/models/locationResults.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider(
          create: (context) => LocationResultsModel(),
          child: Stack(
              children: [
                GoogleMaps(),
                Search(),
              ],
            ),
          ),
        ),
      );
  }
}
