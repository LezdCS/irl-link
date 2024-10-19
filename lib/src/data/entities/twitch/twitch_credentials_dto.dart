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
    @JsonKey(fromJson: _stringToMap) required TwitchDecodedIdTokenDTO decodedIdToken,
    @JsonKey(fromJson: _stringToMap) required TwitchUserDTO twitchUser,
    required String scopes,
  }) = _TwitchCredentialsDTO;

  factory TwitchCredentialsDTO.fromJson(Map<String, dynamic> json) => _$TwitchCredentialsDTOFromJson(json);
}

// Because in previous versions of the app, the idToken and decodedIdToken were stored as a string
Map<String, dynamic> _stringToMap(dynamic json) {
  if (json is String) {
    return jsonDecode(json) as Map<String, dynamic>; // Convert the string to a Map
  } else if (json is Map<String, dynamic>) {
    return json;
  }
  throw Exception("Unexpected type");
}