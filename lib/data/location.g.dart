// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'addressLocality',
    'streetAddress',
    'addressRegion',
    'postalCode',
    'addressCountry'
  ]);
  return Address(
    addressLocality: json['addressLocality'] as String,
    streetAddress: json['streetAddress'] as String,
    addressRegion: json['addressRegion'] as String,
    postalCode: json['postalCode'] as String,
    addressCountry: json['addressCountry'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'addressLocality': instance.addressLocality,
      'streetAddress': instance.streetAddress,
      'addressRegion': instance.addressRegion,
      'postalCode': instance.postalCode,
      'addressCountry': instance.addressCountry,
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['type', 'coordinates']);
  return Geometry(
    type: json['type'] as String,
    coordinates: (json['coordinates'] as List)
        ?.map((e) => (e as num)?.toDouble())
        ?.toList(),
  );
}

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

Interval _$IntervalFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['start', 'end']);
  return Interval(
    start: json['start'] as int,
    end: json['end'] as int,
  );
}

Map<String, dynamic> _$IntervalToJson(Interval instance) => <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };

ReviewMeta _$ReviewMetaFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['veganRatingTotal', 'veganRatingCount']);
  return ReviewMeta(
    veganRatingTotal: json['veganRatingTotal'] as int,
    veganRatingCount: json['veganRatingCount'] as int,
  );
}

Map<String, dynamic> _$ReviewMetaToJson(ReviewMeta instance) =>
    <String, dynamic>{
      'veganRatingTotal': instance.veganRatingTotal,
      'veganRatingCount': instance.veganRatingCount,
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    '_id',
    'address',
    'geo',
    'lastScraperRun',
    'menuId',
    'name',
    'openingHours',
    'priceRange',
    'restaurantId',
    'reviewMeta',
    'telephone',
    'url'
  ]);
  return Location(
    id: json['_id'] as String,
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    geo: json['geo'] == null
        ? null
        : Geometry.fromJson(json['geo'] as Map<String, dynamic>),
    lastScraperRun: json['lastScraperRun'] == null
        ? null
        : DateTime.parse(json['lastScraperRun'] as String),
    menuId: json['menuId'] == null
        ? null
        : Menu.fromJson(json['menuId'] as Map<String, dynamic>),
    name: json['name'] as String,
    openingHours: (json['openingHours'] as List)
        ?.map((e) =>
            e == null ? null : Interval.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    priceRange: json['priceRange'] as String,
    restaurantId: json['restaurantId'] as String,
    reviewMeta: json['reviewMeta'] == null
        ? null
        : ReviewMeta.fromJson(json['reviewMeta'] as Map<String, dynamic>),
    telephone: json['telephone'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      '_id': instance.id,
      'address': instance.address,
      'geo': instance.geo,
      'lastScraperRun': instance.lastScraperRun?.toIso8601String(),
      'menuId': instance.menuId,
      'name': instance.name,
      'openingHours': instance.openingHours,
      'priceRange': instance.priceRange,
      'restaurantId': instance.restaurantId,
      'reviewMeta': instance.reviewMeta,
      'telephone': instance.telephone,
      'url': instance.url,
    };
