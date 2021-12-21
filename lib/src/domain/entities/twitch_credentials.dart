import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:irllink/src/domain/entities/twitch_decoded_idtoken.dart';
import 'package:irllink/src/domain/entities/twitch_user.dart';

class TwitchCredentials extends Equatable {
  final String accessToken;
  final String idToken;
  final String refreshToken;
  final String expiresIn;
  final TwitchDecodedIdToken decodedIdToken;
  final TwitchUser twitchUser;

  const TwitchCredentials({
    required this.accessToken,
    required this.idToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.decodedIdToken,
    required this.twitchUser,
  });

  Map toJson() => {
        'accessToken': accessToken,
        'idToken': idToken,
        'refreshToken': refreshToken,
        'expiresIn': expiresIn,
        'decodedIdToken': jsonEncode(decodedIdToken),
        'twitchUser': jsonEncode(twitchUser),
      };

  @override
  List<Object?> get props {
    return [
      accessToken,
      idToken,
      refreshToken,
      expiresIn,
      decodedIdToken,
      twitchUser,
    ];
  }

  @override
  bool get stringify => true;
}
