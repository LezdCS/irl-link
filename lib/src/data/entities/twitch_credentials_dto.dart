import 'dart:convert';

import 'package:irllink/src/data/entities/twitch_decoded_idtoken_dto.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';

class TwitchCredentialsDTO extends TwitchCredentials {
  const TwitchCredentialsDTO({
    required String accessToken,
    required String idToken,
    required String refreshToken,
    //todo : passer le expiresIn en int à la place de String
    required String expiresIn,
    required TwitchDecodedIdTokenDTO decodedIdToken,
  }) : super(
          accessToken: accessToken,
          idToken: idToken,
          refreshToken: refreshToken,
          expiresIn: expiresIn,
          decodedIdToken: decodedIdToken,
        );

  Map toJson() => {
        'accessToken': accessToken,
        'idToken': idToken,
        'refreshToken': refreshToken,
        'expiresIn': expiresIn,
        'decodedIdToken': jsonEncode(decodedIdToken),
      };

  factory TwitchCredentialsDTO.fromJson(Map<String, dynamic> map) {
    return TwitchCredentialsDTO(
      accessToken: map['accessToken'] as String,
      idToken: map['idToken'] as String,
      refreshToken: map['refreshToken'] as String,
      expiresIn: map['refreshToken'] as String,
      decodedIdToken:
          TwitchDecodedIdTokenDTO.fromJson(jsonDecode(map['decodedIdToken'])),
    );
  }
}
