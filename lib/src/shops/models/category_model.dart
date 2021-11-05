import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class ShopCategory {
  String id;
  String name;
  String createdAt;
  String updatedAt;

  ShopCategory({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ShopCategory.fromJson(Map<String, dynamic> json) =>
      _$ShopCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ShopCategoryToJson(this);
}
