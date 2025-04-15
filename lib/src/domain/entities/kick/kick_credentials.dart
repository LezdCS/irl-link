import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/kick/kick_user.dart';

@immutable
class KickCredentials {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final KickUser kickUser;
  final String scopes;

  const KickCredentials({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.kickUser,
    required this.scopes,
  });
}
