import 'package:irllink/src/domain/entities/stream_elements/se_credentials.dart';

class SeCredentialsDTO extends SeCredentials {
  const SeCredentialsDTO({
    required super.accessToken,
    required super.refreshToken,
    required super.expiresIn,
    required super.scopes,
  });

  Map toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'expiresIn': expiresIn,
        'scopes': scopes,
      };

  factory SeCredentialsDTO.fromJson(Map<String, dynamic> map) {
    return SeCredentialsDTO(
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      expiresIn: map['expiresIn'] as int,
      scopes: map['scopes'] as String,
    );
  }
}
