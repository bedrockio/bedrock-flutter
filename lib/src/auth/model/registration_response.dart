import 'package:json_annotation/json_annotation.dart';
import 'package:bedrock_flutter/src/profile/model/user_model.dart';

part 'registration_response.g.dart';

@JsonSerializable()
class RegistrationResponseModel {
  UserModel user;

  RegistrationResponseModel({required this.user});

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json) => _$RegistrationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationResponseModelToJson(this);
}
