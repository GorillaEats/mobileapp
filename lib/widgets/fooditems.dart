import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fooditems.g.dart';

@JsonSerializable()
class FoodItem {
  static const connection = 'lib/data/fooditems.json';
  final String foodName;
  final String subtitle;
  final String modifications;
  bool _isExpanded = false;

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

Future<List<ExpansionPanel>> _buildCard() async {
  List<FoodItem> _allFoodItems = await FoodItem.getFoodItems();

  return _allFoodItems
      .map<ExpansionPanel>((fooditem) => ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text(fooditem.foodName),
                subtitle: Text(fooditem.subtitle),
              );
            },
            isExpanded: fooditem._isExpanded,
            body: ListTile(
              title: Text(fooditem.modifications),
            ),
          ))
      .toList();
}

class FoodItems extends StatefulWidget {
  @override
  _FoodItemsState createState() => _FoodItemsState();
}

class _FoodItemsState extends State<FoodItems> {
  final Future<List<ExpansionPanel>> _allPanels = _buildCard();

  @override
  Widget build(context) {
    return Container(
      child: FutureBuilder(
          future: _allPanels,
          builder: (context, snapshot) {
            Widget widget;
            if (snapshot.hasData) {
              widget = Text('loaded');
            } else {
              widget = Text('not loaded');
            }
            return widget;
          }),
    );
  }
}
