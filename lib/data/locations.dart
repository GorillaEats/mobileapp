import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class Location {
  static const connection = 'lib/data/starbucks.json';
  final String telephone;
  final double lat;
  final double lng;
  final String address;
  final String city;
  final String state;
  final String zipcode;
  final double veganRating;
  final String price;
  final int numOfItems;
  final String name;

  Location(
      {this.telephone,
      this.lat,
      this.lng,
      this.address,
      this.city,
      this.state,
      this.zipcode,
      this.veganRating,
      this.price,
      this.numOfItems,
      this.name});

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
