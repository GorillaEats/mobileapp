import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class Item {
  @JsonKey(required: true)
  String name;

  @JsonKey(required: true)
  String category;

  @JsonKey(required: true)
  List<String> modifications;

  @JsonKey(required: false)
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
