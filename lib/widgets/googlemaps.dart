import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geodesy/geodesy.dart' as geodesy;
import 'package:gorilla_eats/data/locations.dart';
import 'package:gorilla_eats/data/models/restaurantcard.dart';
import 'package:gorilla_eats/data/userlocation.dart';
import 'package:gorilla_eats/screens/loading.dart';
import 'package:gorilla_eats/widgets/mapcards.dart';
import 'package:gorilla_eats/data/models/locationResults.dart';

const double zoomLevel = 13;

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  static LatLng _initialPosition;
  GoogleMapController _googleMapController;

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
      GoogleMapController controller, LocationResultsModel model) async {
    
    setState(() {
      _googleMapController = controller;
    });
    
    final visibleRegion = await controller.getVisibleRegion();
    final southwest = geodesy.LatLng(
        visibleRegion.southwest.latitude, visibleRegion.southwest.longitude);
    final northeast = geodesy.LatLng(
        visibleRegion.northeast.latitude, visibleRegion.northeast.longitude);
    final distance = geodesy.Geodesy().distanceBetweenTwoGeoPoints(
      southwest,
      northeast,
    ).toDouble();
    final radius = distance/2;

    if (_initialPosition != null) {
      await model.updateResults(
        latitude: _initialPosition.latitude,
        longitude: _initialPosition.longitude,
        radius: radius,
      );
    } else {
      await model.updateResults();
    }
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
          },
        );
      }

      markers[marker.markerId.toString()] = marker;
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantCardSelectedModel(),
      child: Container(
        child: _initialPosition == null
            ? LoadingScreen()
            : Consumer<LocationResultsModel>(
                builder: (context, locationResultsModel, child) {
                  return Stack(
                    children: <Widget>[
                      Consumer<RestaurantCardSelectedModel>(
                        builder: (context, restaurantCardSelectedModel, child) {
                          return GoogleMap(
                            onMapCreated: (controller) =>
                                _onMapCreated(controller, locationResultsModel),
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: _initialPosition,
                              zoom: zoomLevel,
                            ),
                            markers: makeMarkers(
                              restaurantCardSelectedModel,
                              restaurantCardSelectedModel.selected,
                              locationResultsModel.results,
                            ).values.toSet(),
                          );
                        },
                      ),
                      if (locationResultsModel.results.isNotEmpty)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child:
                              MapCards(locations: locationResultsModel.results),
                        ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
