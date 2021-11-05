import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class ShopAddress {
  Map<String, dynamic> geometry;
  String city;
  String countryCode;
  String line1;
  String postalCode;
  String region;

  ShopAddress({
    required this.geometry,
    required this.city,
    required this.countryCode,
    required this.line1,
    required this.postalCode,
    required this.region,
  });

  factory ShopAddress.fromJson(Map<String, dynamic> json) =>
      _$ShopAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ShopAddressToJson(this);
}
