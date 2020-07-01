import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gorilla_eats/screens/loading.dart';
import 'package:gorilla_eats/widgets/foodcard.dart';
import 'package:gorilla_eats/data/fooditems.dart';

class CategoryBody extends StatefulWidget {
  @override
  _CategoryBodyState createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  List<dynamic> _allFoodItems;

  @override
  void initState() {
    super.initState();
    FoodCategory.getFoods().then((value) {
      setState(() {
        _allFoodItems = value;
      });
    });
  }

  @override
  Widget build(context) {
    return Container(
        child: _allFoodItems == null
            ? LoadingScreen()
            : Column(
                children: _allFoodItems.map((fooditem) => FoodCard()).toList(),
              ));
  }
}
