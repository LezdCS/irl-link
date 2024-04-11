import 'dart:convert';

import 'package:irllink/src/data/entities/twitch/twitch_decoded_idtoken_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_user_dto.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';

class TwitchCredentialsDTO extends TwitchCredentials {
  const TwitchCredentialsDTO({
    required super.accessToken,
    required super.idToken,
    required super.refreshToken,
    required super.expiresIn,
    required TwitchDecodedIdTokenDTO super.decodedIdToken,
    required TwitchUserDTO super.twitchUser,
    required super.scopes,
  });

  @override
  Map toJson() => {
        'accessToken': accessToken,
        'idToken': idToken,
        'refreshToken': refreshToken,
        'expiresIn': expiresIn,
        'decodedIdToken': jsonEncode(decodedIdToken),
        'twitchUser': jsonEncode(twitchUser),
        'scopes': scopes,
      };

  factory TwitchCredentialsDTO.fromJson(Map<String, dynamic> map) {
    return TwitchCredentialsDTO(
      accessToken: map['accessToken'] as String,
      idToken: map['idToken'] as String,
      refreshToken: map['refreshToken'] as String,
      expiresIn: map['expiresIn'] as String,
      decodedIdToken:
          TwitchDecodedIdTokenDTO.fromJson(jsonDecode(map['decodedIdToken'])),
      twitchUser: TwitchUserDTO.fromJson(jsonDecode(map['twitchUser'])),
      scopes: map['scopes'] as String,
    );
  }
}
