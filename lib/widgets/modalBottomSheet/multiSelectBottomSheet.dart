import 'package:flutter/material.dart';

class MultiSelectBottomSheet extends StatefulWidget {
  final List<String> options;
  final String title;
  final Function(dynamic) onUpdate;
  final List<int> value;

  MultiSelectBottomSheet({
    Key key,
    @required this.options,
    @required this.onUpdate,
    @required this.title,
    @required this.value,
  });

  @override
  _MultiSelectBottomSheetState createState() => _MultiSelectBottomSheetState();
}

class _MultiSelectBottomSheetState extends State<MultiSelectBottomSheet> {
  List<int> value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final isSelectedList = List<bool>.generate(
        widget.options.length, (index) => value.contains(index));

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              FlatButton(
                child: Text(
                  'Reset Filter',
                ),
                onPressed: () {
                  widget.onUpdate(<int>[]);
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
                  children: widget.options
                      .map(
                        (option) => Container(
                          alignment: Alignment.center,
                          width: constraints.maxWidth / widget.options.length -
                              1.5,
                          child: Text(
                            option,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      )
                      .toList(),
                  isSelected: isSelectedList,
                  onPressed: (index) {
                    setState(
                      () {
                        if (value.contains(index)) {
                          value.remove(index);
                        } else {
                          value.add(index);
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
          ButtonBar(
            children: [
              FlatButton(
                child: Text('Cancel'),
                onPressed: () => {Navigator.pop(context)},
              ),
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  widget.onUpdate(value);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
      margin: EdgeInsets.all(15.0),
    );
  }
}
