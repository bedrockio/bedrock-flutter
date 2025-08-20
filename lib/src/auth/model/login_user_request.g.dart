// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUserRequest _$LoginUserRequestFromJson(Map<String, dynamic> json) =>
    LoginUserRequest(
      phone: json['phone'] as String,
      code: json['code'] as String?,
      channel: json['channel'] as String?,
    );

Map<String, dynamic> _$LoginUserRequestToJson(LoginUserRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      if (instance.code case final value?) 'code': value,
      if (instance.channel case final value?) 'channel': value,
    };
