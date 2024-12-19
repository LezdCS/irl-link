// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'se_credentials_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SeCredentialsDTOImpl _$$SeCredentialsDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$SeCredentialsDTOImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
      scopes: json['scopes'] as String,
    );

Map<String, dynamic> _$$SeCredentialsDTOImplToJson(
        _$SeCredentialsDTOImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'scopes': instance.scopes,
    };
