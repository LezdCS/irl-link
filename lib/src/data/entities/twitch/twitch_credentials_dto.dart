import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irllink/src/data/entities/twitch/twitch_decoded_idtoken_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_user_dto.dart';

part 'twitch_credentials_dto.freezed.dart';
part 'twitch_credentials_dto.g.dart';

@freezed
class TwitchCredentialsDTO with _$TwitchCredentialsDTO {
  const factory TwitchCredentialsDTO({
    required String accessToken,
    required String idToken,
    required String refreshToken,
    required String expiresIn,
    @JsonKey(fromJson: _stringToTwitchDecodedIdTokenDTO) required TwitchDecodedIdTokenDTO decodedIdToken,
    @JsonKey(fromJson: _stringToTwitchUserDTO) required TwitchUserDTO twitchUser,
    required String scopes,
  }) = _TwitchCredentialsDTO;

  factory TwitchCredentialsDTO.fromJson(Map<String, dynamic> json) => _$TwitchCredentialsDTOFromJson(json);
}

// Because in previous versions of the app, the twitchUser and decodedIdToken were stored as a string
TwitchDecodedIdTokenDTO _stringToTwitchDecodedIdTokenDTO(dynamic json) {
  if (json is String) {
    return TwitchDecodedIdTokenDTO.fromJson(jsonDecode(json)) ;
  } else if (json is Map<String, dynamic>) {
    return TwitchDecodedIdTokenDTO.fromJson(json);
  }
  throw Exception("Unexpected type");
}

TwitchUserDTO _stringToTwitchUserDTO(dynamic json) {
  if (json is String) {
    return TwitchUserDTO.fromJson(jsonDecode(json)) ;
  } else if (json is Map<String, dynamic>) {
    return TwitchUserDTO.fromJson(json);
  }
  throw Exception("Unexpected type");
}