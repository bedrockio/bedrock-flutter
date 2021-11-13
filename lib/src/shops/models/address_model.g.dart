// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopAddress _$ShopAddressFromJson(Map<String, dynamic> json) => ShopAddress(
      geometry: json['geometry'] as Map<String, dynamic>,
      city: json['city'] as String?,
      countryCode: json['countryCode'] as String?,
      line1: json['line1'] as String?,
      postalCode: json['postalCode'] as String?,
      region: json['region'] as String?,
    );

Map<String, dynamic> _$ShopAddressToJson(ShopAddress instance) =>
    <String, dynamic>{
      'geometry': instance.geometry,
      'city': instance.city,
      'countryCode': instance.countryCode,
      'line1': instance.line1,
      'postalCode': instance.postalCode,
      'region': instance.region,
    };
