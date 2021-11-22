import 'package:equatable/equatable.dart';
import 'package:irllink/src/domain/entities/twitch_decoded_idtoken.dart';

class TwitchCredentials extends Equatable {
  final String accessToken;
  final String idToken;
  final String refreshToken;
  final String expiresIn;
  final TwitchDecodedIdToken decodedIdToken;

  const TwitchCredentials({
    required this.accessToken,
    required this.idToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.decodedIdToken,
  });

  @override
  List<Object?> get props {
    return [
      accessToken,
      idToken,
      refreshToken,
      expiresIn,
      decodedIdToken,
    ];
  }

  @override
  bool get stringify => true;
}
