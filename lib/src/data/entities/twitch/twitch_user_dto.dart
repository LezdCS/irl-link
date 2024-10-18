import 'package:freezed_annotation/freezed_annotation.dart';

part 'twitch_user_dto.freezed.dart';
part 'twitch_user_dto.g.dart';

@freezed 
class TwitchUserDTO with _$TwitchUserDTO {
  const factory TwitchUserDTO({
    required String id,
    required String login,
    @JsonKey(name: 'display_name')
    required String displayName,
    @JsonKey(name: 'broadcaster_type')
    required String broadcasterType,
    required String description,
    @JsonKey(name: 'profile_image_url')
    required String profileImageUrl,
    @JsonKey(name: 'view_count')
    required int viewCount,
  }) = _TwitchUserDTO;

  factory TwitchUserDTO.fromJson(Map<String, dynamic> json) => _$TwitchUserDTOFromJson(json);
}
