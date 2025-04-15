import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irllink/src/data/entities/kick/kick_user_dto.dart';

part 'kick_credentials_dto.freezed.dart';
part 'kick_credentials_dto.g.dart';

@freezed
abstract class KickCredentialsDTO with _$KickCredentialsDTO {
  const factory KickCredentialsDTO({
    required String accessToken,
    required String refreshToken,
    required String expiresIn,
    @JsonKey(fromJson: _stringToKickUserDTO) required KickUserDTO kickUser,
    required String scopes,
  }) = _KickCredentialsDTO;

  factory KickCredentialsDTO.fromJson(Map<String, dynamic> json) =>
      _$KickCredentialsDTOFromJson(json);
}

KickUserDTO _stringToKickUserDTO(json) {
  if (json is String) {
    return KickUserDTO.fromJson(jsonDecode(json));
  } else if (json is Map<String, dynamic>) {
    return KickUserDTO.fromJson(json);
  }
  throw Exception("Unexpected type");
}
