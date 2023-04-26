import 'package:json_annotation/json_annotation.dart';

part 'meta_data.g.dart';

@JsonSerializable()
class MetaData {
  final int total;
  final int skip;
  final int limit;

  const MetaData(this.total, this.skip, this.limit);

  factory MetaData.fromJson(Map<String, dynamic> json) => _$MetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDataToJson(this);
}
