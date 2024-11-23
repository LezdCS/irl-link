import 'package:freezed_annotation/freezed_annotation.dart';

part 'se_credentials_dto.freezed.dart';

@freezed
class SeCredentialsDTO with _$SeCredentialsDTO {
  const factory SeCredentialsDTO({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
    required String scopes,
  }) = _SeCredentialsDTO;

  factory SeCredentialsDTO.fromJson(Map<String, dynamic> map) {
    return SeCredentialsDTO(
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      expiresIn: map['expiresIn'] as int,
      scopes: map['scopes'] as String,
    );
  }
}
