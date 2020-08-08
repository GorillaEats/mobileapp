import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

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
