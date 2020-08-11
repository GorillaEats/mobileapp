import 'package:json_annotation/json_annotation.dart';
import 'package:gorilla_eats/data/location.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class SpiderConfig {
  @JsonKey(required: true)
  final String url;

  @JsonKey(required: true)
  final int maxDepth;

  @JsonKey(required: true)
  final String allow;

  SpiderConfig({this.url, this.maxDepth, this.allow});

  factory SpiderConfig.fromJson(Map<String, dynamic> json) =>
      _$SpiderConfigFromJson(json);
  Map<String, dynamic> toJson() => _$SpiderConfigToJson(this);
}

@JsonSerializable()
class Restaurant {
  @JsonKey(required: true)
  final String defaultMenuId;

  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true)
  final SpiderConfig spider;

  @JsonKey(required: true)
  final ReviewMeta reviewMeta;

  @JsonKey(required: true)
  final int locationCount;

  Restaurant({
    this.defaultMenuId,
    this.name,
    this.spider,
    this.reviewMeta,
    this.locationCount,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}
