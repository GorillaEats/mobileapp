import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fooditems.g.dart';

@JsonSerializable()
class FoodItem {
  static const connection = 'lib/data/fooditems.json';
  final String foodName;
  final String subtitle;
  final List<String> modifications;

  FoodItem({this.foodName, this.subtitle, this.modifications});

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);

  static Future<List<FoodItem>> getFoodItems() async {
    final jsonString = await rootBundle.loadString(connection);
    final dynamic decoded = json.decode(jsonString);
    // ignore: omit_local_variable_types
    final List<FoodItem> foodItems = [];
    for (dynamic item in decoded) {
      final mapItem = item as Map<String, dynamic>;
      final foodItem = FoodItem.fromJson(mapItem);
      foodItems.add(foodItem);
    }
    return foodItems;
  }
}
