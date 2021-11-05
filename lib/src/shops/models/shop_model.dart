import 'package:bedrock_flutter/src/shops/models/address_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'category_model.dart';
import 'image_model.dart';
import 'owner_model.dart';

part 'shop_model.g.dart';

@JsonSerializable()
class Shop {
  String id;
  String name;
  ShopAddress address;
  List<ShopImage> images;
  List<ShopCategory> categories;
  String description;
  Owner? owner;
  String createdAt;
  String updatedAt;

  Shop({
    required this.id,
    required this.name,
    required this.address,
    required this.images,
    required this.categories,
    required this.description,
    this.owner,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);

  Map<String, dynamic> toJson() => _$ShopToJson(this);
}
