import '/src/network/meta_data.dart';
import '/src/products/model/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_list_response.g.dart';

@JsonSerializable()
class ProductListResponse {
  @JsonKey(name: 'data')
  List<Product> items;
  MetaData meta;

  ProductListResponse(this.items, this.meta);
  factory ProductListResponse.fromJson(Map<String, dynamic> json) => _$ProductListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListResponseToJson(this);
}
