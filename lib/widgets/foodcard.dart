import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gorilla_eats/data/fooditems.dart';

class FoodCard extends StatefulWidget {
  final FoodItem foodItem;

  FoodCard({@required this.foodItem});

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  bool _isExpanded = false;

  Widget cardHeader(bool _isExpanded, FoodItem foodItem) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.fromLTRB(30, 30, 30, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                child: Text(foodItem.foodName,
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              Text(foodItem.subtitle),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                if (foodItem.modifications.isNotEmpty)
                  Icon(
                    _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardBody(FoodItem foodItem) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
        child: Column(
            children: foodItem.modifications.map((modification) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.brightness_1, size: 6),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text(modification),
              ),
            ],
          );
        }).toList()),
      ),
    );
  }

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[500],
            width: 1,
          ),
        ),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Column(
          children: <Widget>[
            cardHeader(_isExpanded, widget.foodItem),
            if (_isExpanded && widget.foodItem.modifications.isNotEmpty)
              cardBody(widget.foodItem),
          ],
        ),
      ),
    );
  }
}
