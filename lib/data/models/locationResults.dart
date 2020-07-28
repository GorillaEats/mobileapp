import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:gorilla_eats/data/locations.dart';

const baseUrl = '192.168.0.10:8080';
const locationsPath = '/locations';
const maxSearchDistanceMeters = 20.0 * 1609.0;

class LocationResultsModel extends ChangeNotifier {
  List<Location> _results;

  LocationResultsModel() {
    _results = [];
  }

  Future<void> updateResults({
    double latitude = 32.7792,
    double longitude = -96.8089,
    double radius = 2000.0,
    double veganRating,
    int open,
  }) async {
    var queryParams = {
      'filter.lat': latitude.toString(),
      'filter.long': longitude.toString(),
      'filter.radius':
          radius.clamp(0.0, maxSearchDistanceMeters).toDouble().toString(),
    };

    if (veganRating != null) {
      queryParams['filter.veganRating'] = veganRating.toString();
    }

    if (open != null) {
      queryParams['filter.open'] = open.toString();
    }

    var uri = Uri.http(baseUrl, locationsPath, queryParams);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      dynamic bodyJson = json.decode(response.body);
      var locationsJson = bodyJson['locations'] as List<dynamic>;
      var locations = locationsJson
          .map((dynamic locationJson) =>
              Location.fromJson(locationJson as Map<String, dynamic>))
          .toList();

      _results = locations;

      notifyListeners();
    } else {
      throw Exception('Failed to load locations');
    }
  }

  List<Location> get results => _results;
}
