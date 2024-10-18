// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitch_credentials_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TwitchCredentialsDTOImpl _$$TwitchCredentialsDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$TwitchCredentialsDTOImpl(
      accessToken: json['accessToken'] as String,
      idToken: json['idToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: json['expiresIn'] as String,
      decodedIdToken: TwitchDecodedIdTokenDTO.fromJson(
          json['decodedIdToken'] as Map<String, dynamic>),
      twitchUser:
          TwitchUserDTO.fromJson(json['twitchUser'] as Map<String, dynamic>),
      scopes: json['scopes'] as String,
    );

Map<String, dynamic> _$$TwitchCredentialsDTOImplToJson(
        _$TwitchCredentialsDTOImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'idToken': instance.idToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'decodedIdToken': instance.decodedIdToken,
      'twitchUser': instance.twitchUser,
      'scopes': instance.scopes,
    };
