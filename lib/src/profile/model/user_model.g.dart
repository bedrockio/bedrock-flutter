// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      profileImage: json['profileImage'] as String?,
      phoneNo: json['phoneNo'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{
    'email': instance.email,
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

  writeNotNull('profileImage', instance.profileImage);
  return val;
}
