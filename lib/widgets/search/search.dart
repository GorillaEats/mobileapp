import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gorilla_eats/widgets/search/searchModel.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _textController = TextEditingController();

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
        controller: _textController,
        onSubmitted: (value) => print('onSubmit:' + value),
        onChanged: (value) {
          setState(() {});
        },
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, size: 20.0),
          hintText: 'Enter Location',
          suffixIcon: _textController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _textController.clear();
                    });
                  },
                  icon: Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                )
              : null,
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

  Widget _buildFilterItems(BuildContext context, SearchModel searchModel) {
    final filterItems = searchModel.filters.asMap().entries.map(
      (entry) {
        return entry.value.buildChip(
          context: context,
          onUpdate: (dynamic value) {
            searchModel.updateFilter(entry.key, value);
          },
        );
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
