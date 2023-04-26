import 'package:json_annotation/json_annotation.dart';

part 'registration_request.g.dart';

@JsonSerializable()
class RegistrationRequestModel {
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? phoneNo;
  @JsonKey(includeIfNull: false)
  String? guestUserToken;

  RegistrationRequestModel({this.firstName, this.lastName, this.dateOfBirth, this.phoneNo, this.guestUserToken});

  factory RegistrationRequestModel.fromJson(Map<String, dynamic> json) => _$RegistrationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationRequestModelToJson(this);
}
