library filter_items;

abstract class FilterItem {
  String key;

  FilterItem(this.key);
  void update(dynamic _value);
  String getDisplayValue();
  bool get active;
  dynamic get value;
}

class Select extends FilterItem {
  List<String> options;
  int _value;

  Select(String key, this.options, this._value) : super(key);

  @override
  void update(dynamic value) {
    _value = value as int;
  }

  @override
  String getDisplayValue() {
    if (active) {
      return options[_value];
    } else {
      return key;
    }
  }

  @override
  bool get active => _value != -1;

  @override
  dynamic get value => _value;
}

class MultiSelect extends FilterItem {
  List<String> options;
  List<int> _value;

  MultiSelect(String key, this.options, this._value) : super(key);

  @override
  void update(dynamic value) {
    _value = value as List<int>;
  }

  @override
  String getDisplayValue() {
    if (active) {
      var displayValue = '';
      for (var i = 0; i < _value.length; i++) {
        displayValue += options[_value[i]] + ',';
      }

      return displayValue.substring(0, displayValue.length - 1);
    } else {
      return key;
    }
  }

  @override
  bool get active => _value.isNotEmpty;

  @override
  dynamic get value => _value;
}

class Bool extends FilterItem {
  bool _value;

  Bool(String key, this._value) : super(key);

  @override
  void update(dynamic value) {
    _value = value as bool;
  }

  @override
  String getDisplayValue() {
    return key;
  }

  @override
  bool get active => _value;

  @override
  dynamic get value => _value;
}

class Open extends Bool {
  Open() : super('Open Now', false);
}

class VeganRating extends Select {
  VeganRating() : super('Vegan Rating', ['2.5', '3.5', '4.5'], -1);

  @override
  String getDisplayValue() {
    if (active) {
      return super.getDisplayValue() + '+';
    } else {
      return super.getDisplayValue();
    }
  }
}

class Price extends MultiSelect {
  Price() : super('Price', ['\$', '\$\$', '\$\$\$', '\$\$\$\$'], []);
}
