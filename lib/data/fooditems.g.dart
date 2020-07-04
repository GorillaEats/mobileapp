// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fooditems.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodItem _$FoodItemFromJson(Map<String, dynamic> json) {
  return FoodItem(
      foodName: json['foodName'] as String,
      subtitle: json['subtitle'] as String,
      modifications: (json['modifications'] as List)
          ?.map((dynamic e) => e as String)
          ?.toList());
}

FoodCategory _$FoodCategoryFromJson(Map<String, dynamic> json) {
  return FoodCategory(
    category: json['category'] as String,
  );
}
