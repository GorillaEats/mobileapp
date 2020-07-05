import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:gorilla_eats/data/models/search.dart';
import 'package:gorilla_eats/credentials.dart';

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
      types: ['address'],
      sessionToken: _sessionId,
      language: 'en',
      components: [Component('country', 'us')],
    );

    print('predictions');
    print(_sessionId);
    print(res.errorMessage);
    for (var i = 0; i < res.predictions.length; i++) {
      print(res.predictions[i].description);
    }

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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchModel(),
      child: Container(
        color: _activelySearching ? Colors.white : Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            _buildSearchBar(context),
            if (!_activelySearching)
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
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          TextField(
            controller: _textController,
            onSubmitted: (value) => {FocusScope.of(context).unfocus()},
            onChanged: _handleTextChange,
            onTap: () {
              setState(() {
                _activelySearching = true;
              });
            },
            textInputAction: TextInputAction.search,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: _activelySearching
                  ? SizedBox()
                  : Icon(Icons.search, size: 20.0),
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
                        color:
                            Theme.of(context).buttonTheme.colorScheme.secondary,
                      ),
                    )
                  : null,
            ),
          ),
          if (_activelySearching)
            IconButton(
              icon: Icon(Icons.arrow_back, size: 20.0),
              onPressed: () {
                setState(() {
                  FocusScope.of(context).unfocus();
                  _activelySearching = false;
                });
              },
            ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
        border: Border.all(color: _activelySearching ? Colors.grey[300] : Colors.transparent),
        boxShadow: _activelySearching
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
}
