import 'package:flutter/foundation.dart';
import 'package:gorilla_eats/widgets/search/filterItems.dart' as filter_items;

class SearchModel extends ChangeNotifier {
  List<filter_items.FilterItem> _filters;

  SearchModel(){
    _filters = [
      filter_items.Open(),
      filter_items.VeganRating(),
      filter_items.Price()
    ];
  }

  void search() {}

  void updateFilter(int index, dynamic value) {
    _filters[index].update(value);
    notifyListeners();
  }

  List<filter_items.FilterItem> get filters => _filters;
}
