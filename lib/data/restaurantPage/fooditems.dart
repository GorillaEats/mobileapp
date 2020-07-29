import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fooditems.g.dart';

@JsonSerializable()
class FoodItem {
  static const connection = 'lib/data/restaurantPage/foodItems.json';
  final String foodName;
  final String subtitle;
  final List<String> modifications;
  bool isExpanded = false;

  FoodItem({this.foodName, this.subtitle, this.modifications});

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return _$FoodItemFromJson(json);
  }
}

@JsonSerializable()
class FoodCategory {
  static const connection = 'lib/data/restaurantPage/foodItems.json';
  final String category;

  FoodCategory({this.category});

  factory FoodCategory.fromJson(Map<String, dynamic> json) =>
      _$FoodCategoryFromJson(json);

  static Future<List<dynamic>> getFoods() async {
    final jsonString = await rootBundle.loadString(connection);
    final dynamic decoded = json.decode(jsonString);
    final categories = <dynamic>[];

    for (dynamic category in decoded) {
      final foodCategoryJson = category as Map<String, dynamic>;
      final foodCategory = FoodCategory.fromJson(foodCategoryJson);
      final foods = <FoodItem>[];

      for (dynamic food in category['foods']) {
        final foodItemJson = food as Map<String, dynamic>;
        final foodItem = FoodItem.fromJson(foodItemJson);
        foods.add(foodItem);
      }

      categories.add([foodCategory, foods]);
    }
    return categories;
  }
}
