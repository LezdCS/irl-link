// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'se_credentials_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeCredentialsDTO _$SeCredentialsDTOFromJson(Map<String, dynamic> json) =>
    _SeCredentialsDTO(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
      scopes: json['scopes'] as String,
    );

Map<String, dynamic> _$SeCredentialsDTOToJson(_SeCredentialsDTO instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'scopes': instance.scopes,
    };
