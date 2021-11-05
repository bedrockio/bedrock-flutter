import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable()
class ShopImage {
  String id;
  String filename;
  String owner;
  String thumbnailUrl;
  String storageType;
  String rawUrl;
  String hash;
  String mimeType;
  String createdAt;
  String updatedAt;

  ShopImage({
    required this.id,
    required this.filename,
    required this.owner,
    required this.thumbnailUrl,
    required this.storageType,
    required this.rawUrl,
    required this.hash,
    required this.mimeType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ShopImage.fromJson(Map<String, dynamic> json) =>
      _$ShopImageFromJson(json);

  Map<String, dynamic> toJson() => _$ShopImageToJson(this);
}
