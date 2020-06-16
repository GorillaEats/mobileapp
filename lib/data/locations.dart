import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

const connection = 'lib/data/starbucks.json';

@JsonSerializable()
class Location {
  Location({this.lat, this.lng, this.address, this.name});

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  final double lat;
  final double lng;
  final String address;
  final String name;
}

Future<List<Location>> getNearbyLocations() async {
  final dynamic parsed = await getDBLocations();
  // ignore: omit_local_variable_types
  final List<Location> locations = [];
  for (dynamic item in parsed) {
    final mapItem = item as Map<String, dynamic>;
    final locationItem = Location.fromJson(mapItem);
    locations.add(locationItem);
  }
  return locations;
}

Future<dynamic> getDBLocations() async {
  final jsonString = await rootBundle.loadString(connection);
  final dynamic decoded = json.decode(jsonString);
  return decoded;
}