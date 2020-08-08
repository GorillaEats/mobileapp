import 'package:json_annotation/json_annotation.dart';
import 'package:gorilla_eats/data/menu.dart';

part 'locations.g.dart';

@JsonSerializable()
class Location {
  final String id;
  final String telephone;
  final double lat;
  final double lng;
  final String address;
  final String city;
  final String state;
  final String zipcode;
  final double veganRating;
  final String price;
  final int numOfItems;
  final String name;
  final Menu menuId;

  Location({
    this.id,
    this.telephone,
    this.lat,
    this.lng,
    this.address,
    this.city,
    this.state,
    this.zipcode,
    this.veganRating,
    this.price,
    this.numOfItems,
    this.name,
    this.menuId,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
