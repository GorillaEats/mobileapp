library filter_items;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

    return Container(
      margin: EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 0.0),
      child: MaterialButton(
        padding: padding,
        minWidth: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: active ? Colors.red[100] : Colors.white,
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

  Widget buildModalBottomSheet({
    @required BuildContext context,
    @required Function(dynamic) onUpdate,
  }) {
    final isSelectedList =
        List<bool>.generate(options.length, (index) => index == _value);

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                key,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              FlatButton(
                child: Text(
                  'Reset Filter',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onPressed: () {
                  onUpdate(-1);
                  Navigator.pop(context);
                },
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 40.0,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ToggleButtons(
                  selectedColor: Colors.red,
                  fillColor: Colors.red[100],
                  children: options
                      .map(
                        (option) => Container(
                          alignment: Alignment.center,
                          width: constraints.maxWidth / options.length - 1.5,
                          child: Text(
                            option,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      )
                      .toList(),
                  isSelected: isSelectedList,
                  onPressed: (index) {
                    onUpdate(index);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
      margin: EdgeInsets.all(15.0),
    );
  }

  @override
  Widget buildChip({
    @required BuildContext context,
    @required Function(dynamic) onUpdate,
  }) {
    final buttonChildren = <Widget>[
      Text(
        getDisplayValue(),
        style: TextStyle(
          fontSize: 13.0,
          color: active ? Colors.red : Colors.grey[700],
        ),
      ),
      Icon(
        Icons.arrow_drop_down,
        size: 20.0,
        color: active ? Colors.red : Colors.grey[700],
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

  @override
  Widget buildChip({
    @required BuildContext context,
    @required Function(dynamic) onUpdate,
  }) {
    final buttonChildren = <Widget>[
      Text(
        getDisplayValue(),
        style: TextStyle(
          fontSize: 13.0,
          color: active ? Colors.red : Colors.grey[700],
        ),
      ),
      Icon(
        Icons.arrow_drop_down,
        size: 20.0,
        color: active ? Colors.red : Colors.grey[700],
      ),
    ];

    return super._buildChip(
      context: context,
      onPressed: () => {print('MultiSelect')},
      children: buttonChildren,
      padding: EdgeInsets.fromLTRB(10.0, 3.0, 0.0, 3.0),
      active: active,
    );
  }
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

  @override
  Widget buildChip({
    @required BuildContext context,
    @required Function(dynamic) onUpdate,
  }) {
    final buttonChildren = <Widget>[
      Text(
        getDisplayValue(),
        style: TextStyle(
          fontSize: 13.0,
          color: active ? Colors.red : Colors.grey[700],
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
