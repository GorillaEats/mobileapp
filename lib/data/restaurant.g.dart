// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpiderConfig _$SpiderConfigFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['url', 'maxDepth', 'allow']);
  return SpiderConfig(
    url: json['url'] as String,
    maxDepth: json['maxDepth'] as int,
    allow: json['allow'] as String,
  );
}

Map<String, dynamic> _$SpiderConfigToJson(SpiderConfig instance) =>
    <String, dynamic>{
      'url': instance.url,
      'maxDepth': instance.maxDepth,
      'allow': instance.allow,
    };

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'defaultMenuId',
    'name',
    'spider',
    'reviewMeta',
    'locationCount'
  ]);
  return Restaurant(
    defaultMenuId: json['defaultMenuId'] as String,
    name: json['name'] as String,
    spider: json['spider'] == null
        ? null
        : SpiderConfig.fromJson(json['spider'] as Map<String, dynamic>),
    reviewMeta: json['reviewMeta'] == null
        ? null
        : ReviewMeta.fromJson(json['reviewMeta'] as Map<String, dynamic>),
    locationCount: json['locationCount'] as int,
  );
}

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'defaultMenuId': instance.defaultMenuId,
      'name': instance.name,
      'spider': instance.spider,
      'reviewMeta': instance.reviewMeta,
      'locationCount': instance.locationCount,
    };
