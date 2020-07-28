import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gorilla_eats/data/locations.dart';
import 'package:gorilla_eats/data/models/restaurantcard.dart';
import 'package:gorilla_eats/data/models/search.dart';
import 'package:gorilla_eats/data/userlocation.dart';
import 'package:gorilla_eats/screens/loading.dart';
import 'package:gorilla_eats/widgets/mapcards.dart';
import 'package:provider/provider.dart';

const double zoomLevel = 15;

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  static LatLng _initialPosition;
  static List<Location> _nearbyLocations = [];
  static bool _renderedMap = false;
  static GoogleMapController _controller;

  @override
  void initState() {
    super.initState();
    getUserLocation().then((position) {
      setState(() {
        _initialPosition = position;
      });
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final nearbyLocations = await Location.getNearbyLocations();
    setState(() {
      _renderedMap = true;
      _controller = controller;
      _nearbyLocations = nearbyLocations;
    });
  }

  Map<String, Marker> makeMarkers(
      RestaurantCardSelectedModel model, String selected) {
    var markers = <String, Marker>{};

    for (var i = 0; i < _nearbyLocations.length; i++) {
      var location = _nearbyLocations[i];
      Marker marker;
      if (location.id == selected) {
        marker = Marker(
          markerId: MarkerId(location.id),
          position: LatLng(location.lat, location.lng),
          icon: BitmapDescriptor.defaultMarkerWithHue(200),
        );
      } else {
        marker = Marker(
            markerId: MarkerId(location.id),
            position: LatLng(location.lat, location.lng),
            icon: BitmapDescriptor.defaultMarkerWithHue(10),
            onTap: () {
              model.updateSelectedCard(location.id);
            });
      }

      markers[marker.markerId.toString()] = marker;
    }

    return markers;
  }

  void moveCamera(SearchModel searchModel) {
    if (_renderedMap) {
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: zoomLevel,
        target: searchModel.selectedPlace != null
            ? searchModel.selectedLatLng
            : _initialPosition,
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantCardSelectedModel(),
      child: Container(
        child: _initialPosition == null
            ? LoadingScreen()
            : Stack(
                children: <Widget>[
                  Consumer<RestaurantCardSelectedModel>(
                    builder: (context, restaurantCardSelectedModel, child) {
                      return GoogleMap(
                        onMapCreated: _onMapCreated,
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: _initialPosition,
                          zoom: zoomLevel,
                        ),
                        markers: makeMarkers(restaurantCardSelectedModel,
                                restaurantCardSelectedModel.selected)
                            .values
                            .toSet(),
                      );
                    },
                  ),
                  Consumer<SearchModel>(
                    builder: (context, searchModel, child) {
                      moveCamera(searchModel);
                      return Container();
                    },
                  ),
                  if (_nearbyLocations.isNotEmpty)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: MapCards(locations: _nearbyLocations),
                    ),
                ],
              ),
      ),
    );
  }
}
