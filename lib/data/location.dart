import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Address {
  @JsonKey(required: true)
  final String addressLocality;

  @JsonKey(required: true)
  final String streetAddress;

  @JsonKey(required: true)
  final String addressRegion;

  @JsonKey(required: true)
  final String postalCode;

  @JsonKey(required: true)
  final String addressCountry;

  Address({
    this.addressLocality,
    this.streetAddress,
    this.addressRegion,
    this.postalCode,
    this.addressCountry,
  });

  @override
  String toString(){
    return '$streetAddress,$addressLocality,$addressRegion,$postalCode';
  }

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Geometry {
  @JsonKey(required: true)
  final String type;

  @JsonKey(required: true)
  final List<double> coordinates;

  Geometry({this.type, this.coordinates});

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

@JsonSerializable()
class Interval {
  @JsonKey(required: true)
  final int start;

  @JsonKey(required: true)
  final int end;

  Interval({this.start, this.end});

  factory Interval.fromJson(Map<String, dynamic> json) =>
      _$IntervalFromJson(json);
  Map<String, dynamic> toJson() => _$IntervalToJson(this);
}

@JsonSerializable()
class ReviewMeta {
  @JsonKey(required: true)
  final int veganRatingTotal;

  @JsonKey(required: true)
  final int veganRatingCount;

  @JsonKey(ignore: true)
  final double veganRating;

  ReviewMeta({
    this.veganRatingTotal,
    this.veganRatingCount,
  }) : veganRating = veganRatingTotal / veganRatingCount;

  factory ReviewMeta.fromJson(Map<String, dynamic> json) =>
      _$ReviewMetaFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewMetaToJson(this);
}

@JsonSerializable()
class Location {
  @JsonKey(required: true, name: '_id')
  final String id;

  @JsonKey(required: true)
  final Address address;

  @JsonKey(required: true)
  final Geometry geo;

  @JsonKey(required: true)
  final DateTime lastScraperRun;

  // TODO: menuId will become type Menu
  @JsonKey(required: true)
  final dynamic menuId;

  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true)
  final List<Interval> openingHours;

  @JsonKey(required: true)
  final String priceRange;

  @JsonKey(required: true)
  final String restaurandId;

  @JsonKey(required: true)
  final ReviewMeta reviewMeta;

  @JsonKey(required: true)
  final String telephone;

  @JsonKey(required: true)
  final String url;

  @JsonKey(ignore: true)
  final int numOfItems;


  Location({
    this.id,
    this.address,
    this.geo,
    this.lastScraperRun,
    this.menuId,
    this.name,
    this.openingHours,
    this.priceRange,
    this.restaurandId,
    this.reviewMeta,
    this.telephone,
    this.url,
  }): numOfItems = (menuId['items'] as List<dynamic>).length;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
