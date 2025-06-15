import 'package:freezed_annotation/freezed_annotation.dart';

part 'se_credentials_dto.freezed.dart';
part 'se_credentials_dto.g.dart';

@freezed
abstract class SeCredentialsDTO with _$SeCredentialsDTO {
  const factory SeCredentialsDTO({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'expires_in') required int expiresIn,
    @JsonKey(name: 'scopes') required String scopes,
  }) = _SeCredentialsDTO;

  factory SeCredentialsDTO.fromJson(Map<String, dynamic> json) =>
      _$SeCredentialsDTOFromJson(json);
}
