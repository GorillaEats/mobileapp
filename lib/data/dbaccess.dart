import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<dynamic> getDBLocations(LatLng position) async {
  final jsonString = await rootBundle.loadString('lib/data/starbucks.json');
  final dynamic decoded = json.decode(jsonString);
  return decoded;
}
