// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUserRequest _$LoginUserRequestFromJson(Map<String, dynamic> json) =>
    LoginUserRequest(
      phoneNo: json['phoneNo'] as String,
      code: json['code'] as String?,
      guestUserToken: json['guestUserToken'] as String?,
    );

Map<String, dynamic> _$LoginUserRequestToJson(LoginUserRequest instance) {
  final val = <String, dynamic>{
    'phoneNo': instance.phoneNo,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  writeNotNull('guestUserToken', instance.guestUserToken);
  return val;
}