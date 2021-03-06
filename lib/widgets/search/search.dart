import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:gorilla_eats/data/models/search.dart';
import 'package:gorilla_eats/credentials.dart';
import 'package:gorilla_eats/widgets/restaurantcard.dart';
import 'package:gorilla_eats/data/location.dart' as gorilla_location;

// Time of Inactivity before a new session id is created for autocomplete requests
// Inactivity is defined as not typing in search bar
const sessionTimeOut = 1 * 60 * 1000;

// Time of Inactivity needed before a request for suggestions are made
const debounceTimeOut = 300;

final uuid = Uuid();

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _textController;
  GoogleMapsPlaces _places;
  String _sessionId;
  int _lastSessionUse;
  Timer _debounce;
  bool _activelySearching;
  List<Prediction> _predictions;
  Prediction _selectedPrediction;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController();
    _places = GoogleMapsPlaces(
      apiKey: googlePlacesApiKey,
    );
    _sessionId = uuid.v4();
    _lastSessionUse = DateTime.now().millisecondsSinceEpoch;
    _debounce = Timer(Duration(milliseconds: 0), () {});
    _predictions = [];
    _activelySearching = false;
  }

  Future<void> _handleDebounceTimeOut(String value) async {
    final res = await _places.autocomplete(
      value,
      sessionToken: _sessionId,
      language: 'en',
      components: [Component('country', 'us')],
    );

    if (res.isOkay || res.hasNoResults) {
      setState(() {
        _predictions = res.predictions;
      });
    }
  }

  void _handleTextChange(String value) {
    setState(() {
      final currentTime = DateTime.now().millisecondsSinceEpoch;

      if (currentTime - _lastSessionUse > sessionTimeOut) {
        _sessionId = uuid.v4();
      }

      _lastSessionUse = currentTime;

      _debounce.cancel();

      _debounce = Timer(
        Duration(milliseconds: debounceTimeOut),
        () => {_handleDebounceTimeOut(value)},
      );
    });
  }

  String _handleSetLocation(Prediction prediction) {
    setState(() {
      FocusScope.of(context).unfocus();
      _predictions = [];
      _selectedPrediction = prediction;
      _debounce.cancel();
      _activelySearching = false;
      _textController.text = _selectedPrediction.description;
    });

    return prediction.placeId;
  }

  void _handleSearchClear() {
    setState(() {
      _predictions = [];
      _textController.clear();
      _debounce.cancel();

      if (!_activelySearching) {
        _selectedPrediction = null;
      }
    });
  }

  void _handleSearchActive() {
    setState(() {
      _activelySearching = true;
    });
  }

  void _handleSearchCancel() {
    setState(() {
      FocusScope.of(context).unfocus();
      _predictions = [];
      _debounce.cancel();
      _activelySearching = false;

      if (_selectedPrediction != null) {
        _textController.text = _selectedPrediction.description;
      } else {
        _textController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<SearchModel>(
                builder: (context, searchModel, child) {
                  return Container(
                    decoration: BoxDecoration(
                      color: _activelySearching || searchModel.listView
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).padding.top,
                        ),
                        _buildSearchBar(context, searchModel),
                      ],
                    ),
                  );
                },
              ),
              Consumer<SearchModel>(
                builder: (context, searchModel, child) {
                  if (!_activelySearching || searchModel.listView) {
                    return Container(
                        color: searchModel.listView
                            ? Colors.white
                            : Colors.transparent,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: _buildFilterItems(context, searchModel));
                  }
                  return Container();
                },
              ),
              Consumer<SearchModel>(
                builder: (context, searchModel, child) {
                  return Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: WillPopScope(
                            onWillPop: () {
                              _activelySearching
                                  ? _handleSearchCancel()
                                  : searchModel.updateListView(false);
                              return Future.value(false);
                            },
                            child: Stack(
                              children: <Widget>[
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  height: searchModel.listView
                                      ? constraints.maxHeight
                                      : 0.0,
                                  color: Colors.white,
                                  child: _buildRestaurantList(
                                      context, searchModel.results),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  height: _activelySearching
                                      ? constraints.maxHeight
                                      : 0.0,
                                  color: Colors.white,
                                  child: _buildPredictionResults(context),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, SearchModel searchModel) {
    const searchBarHeight = 40.0;
    const searchBarIconSize = 20.0;

    return Container(
      height: searchBarHeight,
      margin: EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          TextField(
            controller: _textController,
            onSubmitted: (value) => {FocusScope.of(context).unfocus()},
            onChanged: _handleTextChange,
            onTap: () {
              _handleSearchActive();
            },
            textInputAction: TextInputAction.search,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(0),
              border: InputBorder.none,
              prefixIcon: _activelySearching
                  ? SizedBox()
                  : Icon(Icons.search, size: searchBarIconSize),
              prefixIconConstraints: BoxConstraints(
                  minHeight: searchBarHeight, minWidth: searchBarHeight),
              hintText: 'Enter Location',
              suffixIcon: _textController.text.isNotEmpty
                  ? IconButton(
                      onPressed: _handleSearchClear,
                      icon: Icon(
                        Icons.clear,
                        color:
                            Theme.of(context).buttonTheme.colorScheme.secondary,
                      ),
                    )
                  : null,
            ),
          ),
          if (_activelySearching)
            IconButton(
              icon: Icon(Icons.arrow_back, size: searchBarIconSize),
              onPressed: _handleSearchCancel,
            ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
        border: Border.all(
            color: _activelySearching || searchModel.listView
                ? Colors.grey[200]
                : Colors.transparent),
        boxShadow: _activelySearching || searchModel.listView
            ? null
            : [
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

  Widget _buildRestaurantList(
      BuildContext context, List<gorilla_location.Location> locations) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Container(
                  height: 150,
                  child: RestaurantCard(
                    location: locations[index],
                    onMap: false,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 0,
                ),
            itemCount: locations.length),
      ),
    );
  }

  Widget _buildPredictionResults(BuildContext context) {
    return Container(
      child: ListView.separated(
        padding: EdgeInsets.all(0),
        itemCount: _predictions.length,
        itemBuilder: (context, index) {
          return FlatButton(
              onPressed: () {
                var placeID = _handleSetLocation(_predictions[index]);
                Provider.of<SearchModel>(context, listen: false)
                    .updateSelectedPlace(placeID);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(_predictions[index].description),
              ));
        },
        separatorBuilder: (context, index) => Divider(
          height: 3.0,
          thickness: 1.0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _places.dispose();
    _textController.dispose();
    _debounce.cancel();
  }
}
