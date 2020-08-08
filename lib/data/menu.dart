import 'package:json_annotation/json_annotation.dart';
import 'package:gorilla_eats/data/item.dart';

part 'menu.g.dart';

@JsonSerializable()
class Item{
  String name;
  String category;
  List<String> modifications;
  List<String> tags;

  Item({this.name, this.category, this.modifications, this.tags});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Menu {
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
