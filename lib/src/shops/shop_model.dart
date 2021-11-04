import 'package:json_annotation/json_annotation.dart';
import 'owner_model.dart';

part 'shop_model.g.dart';

@JsonSerializable()
class Shop {
  String id;
  String name;
  List<dynamic> images;
  List<dynamic> categories;
  Owner? owner;
  String createdAt;
  String updatedAt;

  Shop({
    required this.id,
    required this.name,
    required this.images,
    required this.categories,
    this.owner,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);

  Map<String, dynamic> toJson() => _$ShopToJson(this);
}
