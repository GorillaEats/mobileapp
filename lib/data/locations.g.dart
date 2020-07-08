// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    telephone: (json['telephone']) as String,
    lat: (json['location']['latitude'] as num)?.toDouble(),
    lng: (json['location']['longitude'] as num)?.toDouble(),
    address: json['location']['streetAddress'] as String,
    city: json['location']['addressLocality'] as String,
    state: json['location']['addressRegion'] as String,
    zipcode: json['location']['postalCode'] as String,
    rating: json['rating'] as double,
    price: json['price'] as String,
    name: json['name'] as String,
  );
}
