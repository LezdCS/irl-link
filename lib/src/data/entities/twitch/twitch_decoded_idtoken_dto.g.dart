// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitch_decoded_idtoken_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TwitchDecodedIdTokenDTO _$TwitchDecodedIdTokenDTOFromJson(
        Map<String, dynamic> json) =>
    _TwitchDecodedIdTokenDTO(
      preferredUsername: json['preferredUsername'] as String,
      profilePicture: json['profilePicture'] as String,
    );

Map<String, dynamic> _$TwitchDecodedIdTokenDTOToJson(
        _TwitchDecodedIdTokenDTO instance) =>
    <String, dynamic>{
      'preferredUsername': instance.preferredUsername,
      'profilePicture': instance.profilePicture,
    };
