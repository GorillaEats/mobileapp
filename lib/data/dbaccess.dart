import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const connection = 'lib/data/starbucks.json';

Future<dynamic> getDBLocations(LatLng position) async {
  final jsonString = await rootBundle.loadString(connection);
  final dynamic decoded = json.decode(jsonString);
  return decoded;
}
