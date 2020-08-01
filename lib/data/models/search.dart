import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:gorilla_eats/widgets/search/filterItems.dart' as filter_items;
import 'package:gorilla_eats/credentials.dart';

class SearchModel extends ChangeNotifier {
  List<filter_items.FilterItem> _filters;
  String _selectedPlace;
  LatLng _selectedLatLng;
  GoogleMapController _controller;
  bool _listView = false;

  SearchModel() {
    _filters = [
      filter_items.Open(),
      filter_items.VeganRating(),
      filter_items.Price()
    ];
  }

  void search() {}

  void updateFilter(int index, dynamic value) {
    _filters[index].update(value);
    notifyListeners();
  }

  void updateController(GoogleMapController controller) {
    _controller = controller;
  }

  Future<void> updateSelectedPlace(String placeID) async {
    _selectedPlace = placeID;

    if (placeID != null) {
      final geocoding = GoogleMapsGeocoding(
        apiKey: googlePlacesApiKey,
      );

      final latLng = await geocoding.searchByPlaceId(placeID);
      _selectedLatLng = LatLng(latLng.results[0].geometry.location.lat,
          latLng.results[0].geometry.location.lng);
    }

    await moveCamera();

    notifyListeners();
  }

  Future<void> moveCamera() async {
    if (_controller != null) {
      await _controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(zoom: 15, target: _selectedLatLng)));
    }
  }

  void updateListView(bool val) {
    _listView = val;
  }

  List<filter_items.FilterItem> get filters => _filters;
  String get selectedPlace => _selectedPlace;
  LatLng get selectedLatLng => _selectedLatLng;
  GoogleMapController get googleMapController => _controller;
  bool get listView => _listView;
}
