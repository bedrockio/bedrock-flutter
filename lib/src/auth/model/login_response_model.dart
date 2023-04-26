import 'package:json_annotation/json_annotation.dart';

import 'package:bedrock_flutter/src/profile/model/user_model.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  String token;
  UserModel user;

  LoginResponseModel(this.token, this.user);
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
