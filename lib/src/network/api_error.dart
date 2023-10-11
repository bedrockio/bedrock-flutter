import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';

@JsonSerializable()
class ApiError implements Exception {
  String message;
  String? description;
  dynamic details;

  ApiError({required this.message, this.description, this.details});

  factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);

  static String get defaultErrorMessage => 'Something went wrong. Please try again later.';

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);
}
