import 'package:equatable/equatable.dart';

class Twitch extends Equatable {
  final String accessToken;
  final String idToken;
  final String refreshToken;

  const Twitch({
    required this.accessToken,
    required this.idToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props {
    return [
      accessToken,
      idToken,
      refreshToken,
    ];
  }

  @override
  bool get stringify => true;
}
