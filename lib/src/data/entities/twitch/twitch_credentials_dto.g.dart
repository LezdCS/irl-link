// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitch_credentials_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TwitchCredentialsDTO _$TwitchCredentialsDTOFromJson(
        Map<String, dynamic> json) =>
    _TwitchCredentialsDTO(
      accessToken: json['accessToken'] as String,
      idToken: json['idToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: json['expiresIn'] as String,
      decodedIdToken: _stringToTwitchDecodedIdTokenDTO(json['decodedIdToken']),
      twitchUser: _stringToTwitchUserDTO(json['twitchUser']),
      scopes: json['scopes'] as String,
    );

Map<String, dynamic> _$TwitchCredentialsDTOToJson(
        _TwitchCredentialsDTO instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'idToken': instance.idToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'decodedIdToken': instance.decodedIdToken,
      'twitchUser': instance.twitchUser,
      'scopes': instance.scopes,
    };
