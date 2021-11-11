import 'package:equatable/equatable.dart';
import 'package:irllink/src/domain/entities/twitch_decoded_idtoken.dart';

class TwitchCredentials extends Equatable {
  final String accessToken;
  final String idToken;
  final String refreshToken;
  final TwitchDecodedIdToken decodedIdToken;

  const TwitchCredentials({
    required this.accessToken,
    required this.idToken,
    required this.refreshToken,
    required this.decodedIdToken,
  });

  @override
  List<Object?> get props {
    return [
      accessToken,
      idToken,
      refreshToken,
      decodedIdToken,
    ];
  }

  @override
  bool get stringify => true;
}
