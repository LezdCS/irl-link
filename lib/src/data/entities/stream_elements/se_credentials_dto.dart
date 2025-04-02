import 'package:freezed_annotation/freezed_annotation.dart';

part 'se_credentials_dto.freezed.dart';
part 'se_credentials_dto.g.dart';

@freezed
abstract class SeCredentialsDTO with _$SeCredentialsDTO {
  const factory SeCredentialsDTO({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
    required String scopes,
  }) = _SeCredentialsDTO;

  factory SeCredentialsDTO.fromJson(Map<String, dynamic> json) =>
      _$SeCredentialsDTOFromJson(json);
}
