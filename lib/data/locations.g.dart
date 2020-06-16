// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    lat: (json['location']['latitude'] as num)?.toDouble(),
    lng: (json['location']['longitude'] as num)?.toDouble(),
    address: json['location']['streetAddress'] as String,
    name: json['name'] as String,
  );
}
