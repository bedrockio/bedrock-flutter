import 'package:json_annotation/json_annotation.dart';

part 'registration_request.g.dart';

@JsonSerializable()
class RegistrationRequestModel {
  String firstName;
  String lastName;
  String? phoneNumber;

  RegistrationRequestModel({required this.firstName, required this.lastName, this.phoneNumber});

  factory RegistrationRequestModel.fromJson(Map<String, dynamic> json) => _$RegistrationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationRequestModelToJson(this);
}
