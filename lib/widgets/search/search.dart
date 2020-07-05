import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:gorilla_eats/data/models/search.dart';
import 'package:gorilla_eats/credentials.dart';

const sessionTimeOut = 1 * 60 * 1000;
final uuid = Uuid();

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _textController;
  GoogleMapsPlaces _places;
  String sessionId;
  int lastSessionUse;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController();
    _places = GoogleMapsPlaces(
      apiKey: googlePlacesApiKey,
    );
    sessionId = uuid.v4();
    lastSessionUse = DateTime.now().millisecondsSinceEpoch;
  }

  Future<void> _handleTextChange(String value) async {
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if(currentTime - lastSessionUse > sessionTimeOut){
      sessionId = uuid.v4();
    }

    lastSessionUse = currentTime;

    final res = await _places.autocomplete(
      value,
      types: ['address'],
      sessionToken: sessionId,
      language: 'en',
      components: [Component('country', 'us')]
    );

    print('predictions');
    print(sessionId);
    print(res.errorMessage);
    for (var i = 0; i < res.predictions.length; i++) {
      print(res.predictions[i].description);
    }

    setState(() {});
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
        controller: _textController,
        onSubmitted: (value) => {FocusScope.of(context).unfocus()},
        onChanged: _handleTextChange,
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
                    color: Theme.of(context).buttonTheme.colorScheme.secondary,
                  ),
                )
              : null,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
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
