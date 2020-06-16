import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class Location {
  Location({this.lat, this.lng, this.address, this.name});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  static const connection = 'lib/data/starbucks.json';
  final double lat;
  final double lng;
  final String address;
  final String name;

  static Future<List<Location>> getNearbyLocations() async {
    final jsonString = await rootBundle.loadString(connection);
    final dynamic decoded = json.decode(jsonString);
    // ignore: omit_local_variable_types
    final List<Location> locations = [];
    for (dynamic item in decoded) {
      final mapItem = item as Map<String, dynamic>;
      final locationItem = Location.fromJson(mapItem);
      locations.add(locationItem);
    }
    return locations;
  }
}
