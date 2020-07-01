import 'package:flutter/material.dart';
import 'package:gorilla_eats/widgets/categorybody.dart';

class CategoryHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
              child: Text(
                'Entrees',
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
          CategoryBody(),
        ],
      ),
    );
  }
}
