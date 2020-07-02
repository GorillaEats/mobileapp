import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:gorilla_eats/widgets/search/search.dart';
import 'package:gorilla_eats/widgets/googlemaps.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            GoogleMaps(),
            SafeArea(
              child: Search(),
            )
          ],
        ),
      ),
    );
  }
}
