// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationRequestModel _$RegistrationRequestModelFromJson(
        Map<String, dynamic> json) =>
    RegistrationRequestModel(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$RegistrationRequestModelToJson(
        RegistrationRequestModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
    };
