import 'package:json_annotation/json_annotation.dart';
<<<<<<< HEAD
=======
import 'package:gorilla_eats/data/item.dart';
>>>>>>> adding new json classes

part 'menu.g.dart';

@JsonSerializable()
<<<<<<< HEAD
class Item {
  @JsonKey(required: true)
  String name;

  @JsonKey(required: true)
  String category;

  @JsonKey(required: true)
  List<String> modifications;

  @JsonKey(required: true)
  List<String> tags;

  String get subtitle {
    return '${modifications.length} modification${modifications.length != 1 ? 's' : ''}';
  }

  Item({this.name, this.category, this.modifications, this.tags});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Menu {
  static const List<String> categoryTypes = ['Entree', 'Side', 'Dessert'];

=======
class Menu {
>>>>>>> adding new json classes
  @JsonKey(required: true)
  List<Item> items;

  @JsonKey(required: true)
  String source;

  @JsonKey(required: true)
  String restaurantId;

  Menu({this.items, this.source, this.restaurantId});

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
