import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:geodesy/geodesy.dart' as geodesy;
import 'package:gorilla_eats/widgets/search/filterItems.dart' as filter_items;
import 'package:gorilla_eats/credentials.dart';
import 'package:gorilla_eats/data/location.dart' as gorilla_location;

const releaseBaseUrl = 'www.gorillaeats.com';
const debugBaseUrl = '192.168.1.214:8080';
const locationsPath = '/locations';
const maxSearchDistanceMeters = 20.0 * 1609.0;
const defaultZoomLevel = 13.0;
const defaultSearchHeight = 5.0 * 1609.0;
final gd = geodesy.Geodesy();

class SearchModel extends ChangeNotifier {
  List<filter_items.FilterItem> _filters;
  LatLng _selectedLatLng;
  GoogleMapController _controller;
  List<gorilla_location.Location> _results;
  bool _cameraMovedAfterResults;

  SearchModel() {
    _filters = [
      filter_items.Open(),
      filter_items.VeganRating(),
      filter_items.Price()
    ];

    _results = [];
    _cameraMovedAfterResults = false;
  }

  void search() {}

  void updateFilter(int index, dynamic value) {
    _filters[index].update(value);
    notifyListeners();

    updateResults();
  }

  void updateController(GoogleMapController controller) {
    _controller = controller;
  }

  Future<void> updateSelectedPlaceManually() {
    _selectedLatLng = null;
    return updateResults();
  }

  Future<void> updateSelectedPlace(String placeID) async {
    if (placeID != null) {
      final geocoding = GoogleMapsGeocoding(
        apiKey: googlePlacesApiKey,
      );

      final latLng = await geocoding.searchByPlaceId(placeID);
      _selectedLatLng = LatLng(latLng.results[0].geometry.location.lat,
          latLng.results[0].geometry.location.lng);
    }

    await moveCamera();
    await updateResults();

    notifyListeners();
  }

  Future<void> moveCamera() async {
    if (_controller != null) {
      final selectedLatLng =
          geodesy.LatLng(_selectedLatLng.latitude, _selectedLatLng.longitude);
      final southwest = gd.destinationPointByDistanceAndBearing(
          selectedLatLng, defaultSearchHeight / 2, 180.0);
      final northeast = gd.destinationPointByDistanceAndBearing(
          selectedLatLng, defaultSearchHeight / 2, 0.0);

      await _controller.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northeast.latitude, northeast.longitude),
            southwest: LatLng(southwest.latitude, southwest.longitude),
          ),
          10,
        ),
      );
    }
  }

  Future<void> updateResults() async {
    if (_controller == null) {
      return;
    }

    var center = _selectedLatLng;
    var radius = defaultSearchHeight / 2;
    if (_selectedLatLng == null) {
      final visibleRegion = await _controller.getVisibleRegion();
      final southwest = geodesy.LatLng(
          visibleRegion.southwest.latitude, visibleRegion.southwest.longitude);
      final northeast = geodesy.LatLng(
          visibleRegion.northeast.latitude, visibleRegion.northeast.longitude);
      final distance = gd
          .distanceBetweenTwoGeoPoints(
            southwest,
            northeast,
          )
          .toDouble();
      radius = distance / 2;
      center = LatLng(
        (northeast.latitude + southwest.latitude) / 2,
        (northeast.longitude + southwest.longitude) / 2,
      );
    }

    var queryParams = {
      'filter.lat': center.latitude.toString(),
      'filter.long': center.longitude.toString(),
      'filter.radius':
          radius.clamp(0.0, maxSearchDistanceMeters).toDouble().toString(),
    };

    _filters.forEach((filter) {
      filter.buildQuery(queryParams);
    });

    Uri uri;

    if (kReleaseMode) {
      uri = Uri.https(releaseBaseUrl, locationsPath, queryParams);
    } else if (kDebugMode) {
      uri = Uri.http(debugBaseUrl, locationsPath, queryParams);
    }

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      dynamic bodyJson = json.decode(response.body);
      var locationsJson = bodyJson['locations'] as List<dynamic>;
      var locations = locationsJson
          .map((dynamic locationJson) => gorilla_location.Location.fromJson(
              locationJson as Map<String, dynamic>))
          .toList();

      _results = locations;
      _cameraMovedAfterResults = false;

      notifyListeners();
    } else {
      throw Exception('Failed to load locations');
    }
  }

  set selectedLatLng(LatLng selectedLatLng) {
    _selectedLatLng = selectedLatLng;
    updateResults();
  }

  set cameraMovedAfterResults(bool cameraMoved) {
    _cameraMovedAfterResults = cameraMoved;
    notifyListeners();
  }

  List<filter_items.FilterItem> get filters => _filters;
  LatLng get selectedLatLng => _selectedLatLng;
  GoogleMapController get googleMapController => _controller;
  List<gorilla_location.Location> get results => _results;
  bool get cameraMovedAfterResults => _cameraMovedAfterResults;
}
