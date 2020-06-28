import 'package:flutter/material.dart';
import 'package:gorilla_eats/widgets/search/filterItems.dart' as filter_items;
import 'package:provider/provider.dart';
import 'package:gorilla_eats/widgets/search/searchModel.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchModel(),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSearchBar(context),
            Consumer<SearchModel>(
              builder: (context, searchModel, child) {
                return _buildFilterItems(context, searchModel);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.all(10.0),
      child: TextField(
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, size: 20.0),
          hintText: 'Search',
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
          bottomLeft: Radius.circular(18.0),
          bottomRight: Radius.circular(18.0),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 3.0,
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3.0,
          )
        ],
      ),
    );
  }

  Widget _buildFilterItem({
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

  Widget _buildSelectFilterItem({
    @required BuildContext context,
    @required VoidCallback onPressed,
    String childText,
    bool active = false,
  }) {
    final buttonChildren = <Widget>[
      Icon(
        Icons.arrow_drop_down,
        size: 20.0,
        color: active ? Colors.red : Colors.grey[700],
      ),
    ];

    if (childText != null) {
      buttonChildren.insert(
        0,
        Text(
          childText,
          style: TextStyle(
            fontSize: 13.0,
            color: active ? Colors.red : Colors.grey[700],
          ),
        ),
      );
    }

    return _buildFilterItem(
      context: context,
      children: buttonChildren,
      padding: EdgeInsets.fromLTRB(10.0, 3.0, 0.0, 3.0),
      active: active,
      onPressed: onPressed,
    );
  }

  Widget _buildBoolFilterItem({
    @required BuildContext context,
    @required VoidCallback onPressed,
    String childText,
    bool active = false,
  }) {
    List<Widget> buttonChildren;

    if (childText != null) {
      buttonChildren = [
        Text(
          childText,
          style: TextStyle(
            fontSize: 13.0,
            color: active ? Colors.red : Colors.grey[700],
          ),
        ),
      ];
    }

    return _buildFilterItem(
      context: context,
      children: buttonChildren,
      active: active,
      onPressed: onPressed,
    );
  }

  Widget _buildFilterItems(BuildContext context, SearchModel searchModel) {
    final filterItems = searchModel.filters.asMap().entries.map(
      (entry) {
        final index = entry.key;
        if (entry.value is filter_items.Bool) {
          return _buildBoolFilterItem(
            context: context,
            childText: entry.value.getDisplayValue(),
            active: entry.value.active,
            onPressed: () => searchModel.updateFilter(index, !(entry.value.value as bool)),
          );
        } else if (entry.value is filter_items.Select) {
          return _buildSelectFilterItem(
            context: context,
            childText: entry.value.getDisplayValue(),
            active: entry.value.active,
            onPressed: () => print('select'),
          );
        } else if (entry.value is filter_items.MultiSelect) {
          return _buildSelectFilterItem(
            context: context,
            childText: entry.value.getDisplayValue(),
            active: entry.value.active,
            onPressed: () => print('multi select'),
          );
        } else {
          throw ('Invalid filter item type');
        }
      },
    ).toList();

    return Container(
      height: 25.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: 7.0,
          ),
          ...filterItems,
          SizedBox(
            width: 7.0,
          ),
        ],
      ),
    );
  }
}
