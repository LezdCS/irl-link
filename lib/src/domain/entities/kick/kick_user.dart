import 'package:freezed_annotation/freezed_annotation.dart';

part 'kick_user.freezed.dart';

@freezed
abstract class KickUser with _$KickUser {
  const factory KickUser({
    required String id,
    required String username,
    required String bio,
    required String profilePicture,
    required String displayName,
  }) = _KickUser;
}
