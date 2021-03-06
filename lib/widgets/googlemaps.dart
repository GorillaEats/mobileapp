import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gorilla_eats/data/location.dart';
import 'package:gorilla_eats/data/models/restaurantcard.dart';
import 'package:gorilla_eats/data/models/search.dart';
import 'package:gorilla_eats/data/userlocation.dart';
import 'package:gorilla_eats/screens/loading.dart';

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  static LatLng _initialPosition;

  @override
  void initState() {
    super.initState();
    getUserLocation().then((position) {
      setState(() {
        _initialPosition = position;
      });
    });
  }

  Future<void> _onMapCreated(
      GoogleMapController controller, SearchModel searchModel) async {
    searchModel.updateController(controller);

    await searchModel.updateResults();
  }

  Map<String, Marker> makeMarkers(RestaurantCardSelectedModel model,
      String selected, List<Location> locations) {
    var markers = <String, Marker>{};

    for (var i = 0; i < locations.length; i++) {
      var location = locations[i];
      Marker marker;
      if (location.id == selected) {
        marker = Marker(
          markerId: MarkerId(location.id),
          position: LatLng(location.latitude, location.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(200),
        );
      } else {
        marker = Marker(
          markerId: MarkerId(location.id),
          position: LatLng(location.latitude, location.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(10),
          onTap: () {
            model.updateSelectedCard(location.id);
          },
        );
      }

      markers[marker.markerId.toString()] = marker;
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _initialPosition == null
          ? LoadingScreen()
          : Consumer<SearchModel>(
              builder: (context, searchModel, child) {
                return Consumer<RestaurantCardSelectedModel>(
                  builder: (context, restaurantCardSelectedModel, child) {
                    return GoogleMap(
                      onMapCreated: (controller) =>
                          _onMapCreated(controller, searchModel),
                      myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: _initialPosition,
                        zoom: defaultZoomLevel,
                      ),
                      markers: makeMarkers(
                        restaurantCardSelectedModel,
                        restaurantCardSelectedModel.selected,
                        searchModel.results,
                      ).values.toSet(),
                    );
                  },
                );
              },
            ),
    );
  }
}
