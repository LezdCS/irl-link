import 'dart:convert';

import 'package:irllink/src/data/entities/twitch_decoded_idtoken_dto.dart';
import 'package:irllink/src/data/entities/twitch_user_dto.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';

class TwitchCredentialsDTO extends TwitchCredentials {
  const TwitchCredentialsDTO({
    required String accessToken,
    required String idToken,
    required String refreshToken,
    required String expiresIn,
    required TwitchDecodedIdTokenDTO decodedIdToken,
    required TwitchUserDTO twitchUser,
    required String scopes,
  }) : super(
          accessToken: accessToken,
          idToken: idToken,
          refreshToken: refreshToken,
          expiresIn: expiresIn,
          decodedIdToken: decodedIdToken,
          twitchUser: twitchUser,
          scopes: scopes,
        );

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
