import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List<Color> colors = [
  Colors.red[100],
  Colors.red[200],
  Colors.red[300],
  Colors.red[400],
  Colors.red[500]
];

class MapCards extends StatelessWidget {
  Widget _card(Color givenColor) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: SizedBox(
        width: 300,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: givenColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        height: 200,
        child: ListView(
          itemExtent: 300,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          scrollDirection: Axis.horizontal,
          children: colors.map((color) => _card(color)).toList(),
        ),
      ),
    );
  }
}
