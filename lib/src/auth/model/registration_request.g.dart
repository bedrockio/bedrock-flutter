// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationRequestModel _$RegistrationRequestModelFromJson(
        Map<String, dynamic> json) =>
    RegistrationRequestModel(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      phoneNo: json['phoneNo'] as String?,
      guestUserToken: json['guestUserToken'] as String?,
    );

Map<String, dynamic> _$RegistrationRequestModelToJson(
    RegistrationRequestModel instance) {
  final val = <String, dynamic>{
    'firstName': instance.firstName,
    'lastName': instance.lastName,
    'dateOfBirth': instance.dateOfBirth,
    'phoneNo': instance.phoneNo,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('guestUserToken', instance.guestUserToken);
  return val;
}
