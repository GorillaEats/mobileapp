import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Widget header(bool _isExpanded) {
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
              child: Text('FoodName',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            Text('Subtitle'),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Icon(
                _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget body() {
  return Card(
    elevation: 0,
    child: Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.brightness_1, size: 6),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text('point 1'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.brightness_1, size: 6),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text('point 2'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class FoodCard extends StatefulWidget {
  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  bool _isExpanded = false;

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
            header(_isExpanded),
            if (_isExpanded) body(),
          ],
        ),
      ),
    );
  }
}
