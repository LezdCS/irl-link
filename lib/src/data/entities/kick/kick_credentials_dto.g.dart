// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kick_credentials_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KickCredentialsDTO _$KickCredentialsDTOFromJson(Map<String, dynamic> json) =>
    _KickCredentialsDTO(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
      kickUser: KickUserDTO.fromJson(json['kickUser'] as Map<String, dynamic>),
      scopes: json['scopes'] as String,
    );

Map<String, dynamic> _$KickCredentialsDTOToJson(_KickCredentialsDTO instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'kickUser': instance.kickUser,
      'scopes': instance.scopes,
    };
