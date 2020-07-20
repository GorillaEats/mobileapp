import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class RestaurantCardSelectedModel extends ChangeNotifier {
  String _selected;

  void updateSelectedCard(String selected) {
    _selected = selected;
    notifyListeners();
  }

  String get selected => _selected;
}
