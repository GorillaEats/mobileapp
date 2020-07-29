library filter_items;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gorilla_eats/widgets/modalBottomSheet/selectBottomSheet.dart';
import 'package:gorilla_eats/widgets/modalBottomSheet/multiSelectBottomSheet.dart';

abstract class FilterItem {
  String key;

  FilterItem(this.key);
  void update(dynamic _value);
  String getDisplayValue();
  bool get active;
  dynamic get value;

  Widget _buildChip({
    @required BuildContext context,
    @required VoidCallback onPressed,
    EdgeInsets padding,
    List<Widget> children,
    bool active = false,
  }) {
    padding ??= EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0);

    final fillColor = Theme.of(context).toggleButtonsTheme.fillColor;
    final disabledColor = Theme.of(context).toggleButtonsTheme.disabledColor;

    return Container(
      margin: EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 0.0),
      child: MaterialButton(
        padding: padding,
        minWidth: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: active ? fillColor : disabledColor,
        onPressed: onPressed,
        child: children != null
            ? Row(
                children: children,
              )
            : null,
      ),
    );
  }

  Widget buildChip({
    @required BuildContext context,
    @required Function(dynamic) onUpdate,
  });

  void buildQuery(Map<String, dynamic> query);
}

abstract class Select extends FilterItem {
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

  Widget buildModalBottomSheet({
    @required BuildContext context,
    @required Function(dynamic) onUpdate,
  }) {
    final isSelectedList =
        List<bool>.generate(options.length, (index) => index == _value);

    return SelectBottomSheet(
      onUpdate: onUpdate,
      options: options,
      isSelectedList: isSelectedList,
      title: key,
    );
  }

  @override
  Widget buildChip({
    @required BuildContext context,
    @required Function(dynamic) onUpdate,
  }) {
    final selectedColor = Theme.of(context).toggleButtonsTheme.selectedColor;
    final unSelectedColor = Theme.of(context).buttonTheme.colorScheme.secondary;

    final buttonChildren = <Widget>[
      Text(
        getDisplayValue(),
        style: TextStyle(
          fontSize: 13.0,
          color: active ? selectedColor : unSelectedColor,
        ),
      ),
      Icon(
        Icons.arrow_drop_down,
        size: 20.0,
        color: active ? selectedColor : unSelectedColor,
      ),
    ];

    return super._buildChip(
      context: context,
      onPressed: () => {
        showModalBottomSheet<void>(
          context: context,
          builder: (context) {
            return buildModalBottomSheet(
              context: context,
              onUpdate: onUpdate,
            );
          },
        )
      },
      children: buttonChildren,
      padding: EdgeInsets.fromLTRB(10.0, 3.0, 0.0, 3.0),
      active: active,
    );
  }
}

abstract class MultiSelect extends FilterItem {
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
      for (var i = 0; i < options.length; i++) {
        if (_value.contains(i)) {
          displayValue += options[i] + ',';
        }
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

  @override
  Widget buildChip({
    @required BuildContext context,
    @required Function(dynamic) onUpdate,
  }) {
    final selectedColor = Theme.of(context).toggleButtonsTheme.selectedColor;
    final unSelectedColor = Theme.of(context).buttonTheme.colorScheme.secondary;

    final buttonChildren = <Widget>[
      Text(
        getDisplayValue(),
        style: TextStyle(
          fontSize: 13.0,
          color: active ? selectedColor : unSelectedColor,
        ),
      ),
      Icon(
        Icons.arrow_drop_down,
        size: 20.0,
        color: active ? selectedColor : unSelectedColor,
      ),
    ];

    return super._buildChip(
      context: context,
      onPressed: () => {
        showModalBottomSheet<void>(
          context: context,
          builder: (context) {
            return MultiSelectBottomSheet(
              options: options,
              onUpdate: onUpdate,
              title: key,
              value: _value,
            );
          },
        )
      },
      children: buttonChildren,
      padding: EdgeInsets.fromLTRB(10.0, 3.0, 0.0, 3.0),
      active: active,
    );
  }
}

abstract class Bool extends FilterItem {
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

  @override
  Widget buildChip({
    @required BuildContext context,
    @required Function(dynamic) onUpdate,
  }) {
    final selectedColor = Theme.of(context).toggleButtonsTheme.selectedColor;
    final unSelectedColor = Theme.of(context).buttonTheme.colorScheme.secondary;

    final buttonChildren = <Widget>[
      Text(
        getDisplayValue(),
        style: TextStyle(
          fontSize: 13.0,
          color: active ? selectedColor : unSelectedColor,
        ),
      ),
    ];

    return super._buildChip(
      context: context,
      children: buttonChildren,
      active: active,
      onPressed: () {
        onUpdate(!_value);
      },
    );
  }
}

class Open extends Bool {
  Open() : super('Open Now', false);

  @override
  void buildQuery(Map<String, dynamic> query) {
    if (!active) {
      return;
    }

    final now = DateTime.now();
    final weekday = now.weekday % 7;
    final hour = now.hour;
    final minute = now.minute;

    query['filter.open'] = ((weekday * 24 + hour) * 60 + minute).toString();
  }
}

class VeganRating extends Select {
  VeganRating() : super('Vegan Rating', ['3.5+', '4.0+', '4.5+'], -1);

  @override
  void buildQuery(Map<String, dynamic> query) {
    if (!active) {
      return;
    }

    query['filter.veganRating'] =
        options[_value].substring(0, options[_value].length - 1);
  }
}

class Price extends MultiSelect {
  Price() : super('Price', ['\$', '\$\$', '\$\$\$', '\$\$\$\$'], []);

  @override
  void buildQuery(Map<String, dynamic> query) {
    if (!active) {
      return;
    }
  }
}
