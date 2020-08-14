import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gorilla_eats/data/models/search.dart';

Widget listButton(SearchModel searchModel, BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    padding: EdgeInsets.fromLTRB(0, 0, 15, 30),
    alignment: Alignment.bottomRight,
    child: SizedBox(
      height: 60,
      width: 60,
      child: RaisedButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          searchModel.updateListView(true);
        },
        child: Center(
          child: Icon(
            Icons.format_list_bulleted,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}
