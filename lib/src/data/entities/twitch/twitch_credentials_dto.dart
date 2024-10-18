import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irllink/src/data/entities/twitch/twitch_decoded_idtoken_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_user_dto.dart';

part 'twitch_credentials_dto.freezed.dart';
part 'twitch_credentials_dto.g.dart';

@freezed
class TwitchCredentialsDTO with _$TwitchCredentialsDTO {
  const factory TwitchCredentialsDTO({
    required String accessToken,
    required String idToken,
    required String refreshToken,
    required String expiresIn,
    required TwitchDecodedIdTokenDTO decodedIdToken,
    required TwitchUserDTO twitchUser,
    required String scopes,
  }) = _TwitchCredentialsDTO;

  factory TwitchCredentialsDTO.fromJson(Map<String, dynamic> json) => _$TwitchCredentialsDTOFromJson(json);
}
