// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

<<<<<<< HEAD
Item _$ItemFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['name', 'category', 'modifications', 'tags']);
  return Item(
    name: json['name'] as String,
    category: json['category'] as String,
    modifications:
        (json['modifications'] as List)?.map((e) => e as String)?.toList(),
    tags: (json['tags'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'category': instance.category,
      'modifications': instance.modifications,
      'tags': instance.tags,
    };

=======
>>>>>>> adding new json classes
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
