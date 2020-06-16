import 'dart:async' show Future;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dbaccess.dart';

part 'nearbyplaces.g.dart';

@JsonSerializable()
class Location {
  Location({this.lat, this.lng, this.address, this.name});

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  final double lat;
  final double lng;
  final String address;
  final String name;
}

T cast<T>(dynamic x) => x is T ? x : null;

Future<List<Location>> getNearbyLocations() async {
  final dynamic parsed = await getDBLocations();
  // ignore: omit_local_variable_types
  final List<Location> locations = [];
  for (dynamic item in parsed) {
    final mapItem = cast<Map<String, dynamic>>(item);
    final locationItem = Location.fromJson(mapItem);
    locations.add(locationItem);
  }
  return locations;
}
