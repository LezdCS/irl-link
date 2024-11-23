import 'package:freezed_annotation/freezed_annotation.dart';

part 'twitch_decoded_idtoken_dto.freezed.dart';
part 'twitch_decoded_idtoken_dto.g.dart';

@freezed
class TwitchDecodedIdTokenDTO with _$TwitchDecodedIdTokenDTO {
  const factory TwitchDecodedIdTokenDTO({
    required String preferredUsername,
    required String profilePicture,
  }) = _TwitchDecodedIdTokenDTO;

  factory TwitchDecodedIdTokenDTO.fromJson(Map<String, dynamic> json) =>
      _$TwitchDecodedIdTokenDTOFromJson(json);
}
