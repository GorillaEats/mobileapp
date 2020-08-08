// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['items', 'source', 'restaurantId']);
  return Menu(
    items: (json['items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    source: json['source'] as String,
    restaurantId: json['restaurantId'] as String,
  );
}

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'items': instance.items,
      'source': instance.source,
      'restaurantId': instance.restaurantId,
    };
