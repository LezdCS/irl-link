import 'package:irllink/src/domain/entities/twitch.dart';

class TwitchDTO extends Twitch {
  const TwitchDTO({
    required String accessToken,
    required String idToken,
    required String refreshToken,
  }) : super(
          accessToken: accessToken,
          idToken: idToken,
          refreshToken: refreshToken,
        );

  factory TwitchDTO.fromJson(Map<String, dynamic> map) {
    return TwitchDTO(
      accessToken: map['accessToken'] as String,
      idToken: map['idToken'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }
}
