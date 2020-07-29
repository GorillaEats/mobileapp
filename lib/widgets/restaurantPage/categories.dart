import 'package:flutter/material.dart';
import 'package:gorilla_eats/data/restaurantPage/fooditems.dart';
import 'package:gorilla_eats/screens/loading.dart';
import 'package:gorilla_eats/widgets/restaurantPage/foodcard.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<dynamic> _allCategories;

  @override
  void initState() {
    super.initState();
    FoodCategory.getFoods().then((value) {
      setState(() {
        _allCategories = value;
      });
    });
  }

  Widget categoryHeader(String categoryName) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text(
              categoryName,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          width: 350,
          child: Divider(
            color: Colors.black,
            height: 30,
            thickness: 2,
          ),
        ),
      ],
    );
  }

  Widget createCategory(dynamic category) {
    final categoryName = category[0].category.toString();
    final foodItems = category[1] as List<FoodItem>;

    return Column(
      children: <Widget>[
        categoryHeader(categoryName),
        Column(
          children: foodItems.map((foodItem) {
            return FoodCard(
              foodItem: foodItem,
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _allCategories == null
          ? LoadingScreen()
          : Expanded(
              child: ListView(
                children: _allCategories
                    .map((dynamic category) => createCategory(category))
                    .toList(),
              ),
            ),
    );
  }
}
