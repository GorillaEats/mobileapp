import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gorilla_eats/screens/loading.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fooditems.g.dart';

@JsonSerializable()
class FoodItem {
  static const connection = 'lib/data/fooditems.json';
  final String foodName;
  final String subtitle;
  final String modifications;
  bool isExpanded = false;

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

List<ExpansionPanel> _buildCard(List<FoodItem> allFoodItems) {
  return allFoodItems
      .map<ExpansionPanel>((fooditem) => ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text(fooditem.foodName),
                subtitle: Text(fooditem.subtitle),
              );
            },
            body: ListTile(
              title: Text(fooditem.modifications),
            ),
            canTapOnHeader: true,
            isExpanded: fooditem.isExpanded,
          ))
      .toList();
}

class FoodItems extends StatefulWidget {
  @override
  _FoodItemsState createState() => _FoodItemsState();
}

class _FoodItemsState extends State<FoodItems> {
  List<FoodItem> _allFoodItems;
  List<ExpansionPanel> _allCards;

  @override
  void initState() {
    super.initState();
    FoodItem.getFoodItems().then((value) {
      setState(() {
        _allFoodItems = value;
      });
    });
  }

  @override
  Widget build(context) {
    if (_allFoodItems != null) {
      _allCards = _buildCard(_allFoodItems);
    }
    return Container(
        child: _allFoodItems == null
            ? LoadingScreen()
            : ExpansionPanelList(
                expansionCallback: (panelIndex, isExpanded) {
                  setState(() {
                    _allFoodItems.elementAt(panelIndex).isExpanded =
                        !isExpanded;
                  });
                },
                children: _allCards,
              ));
  }
}
