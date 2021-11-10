import 'package:equatable/equatable.dart';

class Twitch extends Equatable {
  final String accessToken;
  final String idToken;
  final String refreshToken;
  final String preferredUsername;

  const Twitch({
    required this.accessToken,
    required this.idToken,
    required this.refreshToken,
    required this.preferredUsername,
  });

  @override
  List<Object?> get props {
    return [
      accessToken,
      idToken,
      refreshToken,
      preferredUsername,
    ];
  }

  @override
  bool get stringify => true;
}
