// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'se_credentials_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeCredentialsDTO _$SeCredentialsDTOFromJson(Map<String, dynamic> json) =>
    _SeCredentialsDTO(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresIn: (json['expires_in'] as num).toInt(),
      scopes: json['scopes'] as String,
    );

Map<String, dynamic> _$SeCredentialsDTOToJson(_SeCredentialsDTO instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expires_in': instance.expiresIn,
      'scopes': instance.scopes,
    };
