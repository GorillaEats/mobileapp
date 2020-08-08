import 'package:flutter/material.dart';
import 'package:gorilla_eats/data/menu.dart';
import 'package:gorilla_eats/widgets/foodcard.dart';

class Categories extends StatefulWidget {
  final Menu menu;

  Categories({
    @required this.menu,
  });

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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

  Widget createCategory(String categoryName, List<Item> items) {
    return Column(
      children: <Widget>[
        categoryHeader(categoryName),
        Column(
          children: items.map((item) {
            return FoodCard(
              foodItem: item,
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Item>> categoryToListOfItems;

    widget.menu.items.forEach((item) {
      if (categoryToListOfItems.containsKey(item.category)) {
        categoryToListOfItems[item.category].add(item);
      } else {
        categoryToListOfItems[item.category] = [item];
      }
    });

    return Container(
      child: Expanded(
        child: ListView(
            children: Menu.categoryTypes
                .map((category) =>
                    createCategory(category, categoryToListOfItems[category]))
                .toList()),
      ),
    );
  }
}
