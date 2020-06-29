import 'package:flutter/material.dart';

class SelectBottomModal extends StatelessWidget {
  final Function(dynamic) onUpdate;
  final List<bool> isSelectedList;
  final List<String> options;
  final String title;

  SelectBottomModal({
    @required this.onUpdate,
    @required this.options,
    @required this.isSelectedList,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
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
}
