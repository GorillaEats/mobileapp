// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    telephone: (json['telephone']) as String,
    lat: (json['geo']['coordinates'][1] as num)?.toDouble(),
    lng: (json['geo']['coordinates'][0] as num)?.toDouble(),
    address: json['address']['streetAddress'] as String,
    city: json['address']['addressLocality'] as String,
    state: json['address']['addressRegion'] as String,
    zipcode: json['address']['postalCode'] as String,
    veganRating: (json['reviewMeta']['veganRatingTotal'] /
        json['reviewMeta']['veganRatingCount']) as double,
    price: json['priceRange'] as String,
    numOfItems: json['menuMeta']['numOfItems'] as int,
    name: json['name'] as String,
  );
}
