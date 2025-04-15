import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irllink/src/data/entities/kick/kick_user_dto.dart';

part 'kick_credentials_dto.freezed.dart';
part 'kick_credentials_dto.g.dart';

@freezed
abstract class KickCredentialsDTO with _$KickCredentialsDTO {
  const factory KickCredentialsDTO({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
    required KickUserDTO kickUser,
    required String scopes,
  }) = _KickCredentialsDTO;

  factory KickCredentialsDTO.fromJson(Map<String, dynamic> json) =>
      _$KickCredentialsDTOFromJson(json);
}
