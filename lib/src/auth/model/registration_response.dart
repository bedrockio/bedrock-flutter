import 'package:json_annotation/json_annotation.dart';

part 'registration_response.g.dart';

@JsonSerializable()
class RegistrationResponseModel {
  String token;

  RegistrationResponseModel({required this.token});

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json) => _$RegistrationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationResponseModelToJson(this);
}
