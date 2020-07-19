import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class RestaurantCardSelectedModel extends ChangeNotifier {
  String _selected;
  int _selectedIdx;

  void updateSelectedCard(String selected, int i) {
    _selected = selected;
    _selectedIdx = i;
    notifyListeners();
  }

  String get selected => _selected;
  int get selectedIdx => _selectedIdx;
}
