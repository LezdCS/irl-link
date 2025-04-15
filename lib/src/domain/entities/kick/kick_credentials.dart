import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irllink/src/domain/entities/kick/kick_user.dart';

part 'kick_credentials.freezed.dart';

@freezed
abstract class KickCredentials with _$KickCredentials {
  const factory KickCredentials({
    required String accessToken,
    required String refreshToken,
    required String expiresIn,
    required KickUser kickUser,
    required String scopes,
  }) = _KickCredentials;
}
