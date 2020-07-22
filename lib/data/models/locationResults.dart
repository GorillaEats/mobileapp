import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gorilla_eats/data/locations.dart';

const baseUrl = '192.168.0.10:8080';
const locationsPath = '/locations';

class LocationResultsModel extends ChangeNotifier {
  List<Location> _results;

  LocationResultsModel() {
    _results = [];
  }

  Future<void> updateResults({
    @required double latitude,
    @required double longitude,
    double radius = 2000,
    double veganRating,
    int open,
  }) async {
    var queryParams = {
      'filter.lat': latitude.toString(),
      'filter.long': longitude.toString(),
      'filter.radius': radius.toString(),
    };

    if (veganRating != null) {
      queryParams['filter.veganRating'] = veganRating.toString();
    }

    if (open != null) {
      queryParams['filter.open'] = open.toString();
    }

    var uri = Uri.http(baseUrl, locationsPath, queryParams);
    print(uri.toString());
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      dynamic bodyJson = json.decode(response.body);
      var locationsJson = bodyJson['locations'] as List<dynamic>;
      var locations = locationsJson
          .map((dynamic locationJson) => Location.fromJson(locationJson as Map<String, dynamic>))
          .toList();

      _results = locations;

      notifyListeners();

    } else {
      throw Exception('Failed to load locations');
    }
  }

  List<Location> get results => _results;
}
