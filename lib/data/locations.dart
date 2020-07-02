import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class Location {
  static const connection = 'lib/data/starbucks.json';
  final double lat;
  final double lng;
  final String address;
  final String name;

  Location({this.lat, this.lng, this.address, this.name});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  static Future<List<Location>> getNearbyLocations() async {
    final jsonString = await rootBundle.loadString(connection);
    final dynamic decoded = json.decode(jsonString);
    final locations = <Location>[];
    for (dynamic item in decoded) {
      final mapItem = item as Map<String, dynamic>;
      final locationItem = Location.fromJson(mapItem);
      locations.add(locationItem);
    }
    return locations;
  }
}
