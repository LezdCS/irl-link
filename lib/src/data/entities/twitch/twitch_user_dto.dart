import 'package:freezed_annotation/freezed_annotation.dart';

part 'twitch_user_dto.freezed.dart';
part 'twitch_user_dto.g.dart';

@freezed
class TwitchUserDTO with _$TwitchUserDTO {
  const factory TwitchUserDTO({
    required String id,
    required String login,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'broadcaster_type') required String broadcasterType,
    required String description,
    @JsonKey(name: 'profile_image_url') required String profileImageUrl,
    @JsonKey(name: 'view_count', fromJson: _stringToInt) required int viewCount,
  }) = _TwitchUserDTO;

  factory TwitchUserDTO.fromJson(Map<String, dynamic> json) =>
      _$TwitchUserDTOFromJson(json);
}

// Because in previous versions of the app, the viewCount was stored as a string (even tho it made no sense to save this in local storage)
int _stringToInt(json) {
  if (json is String) {
    return int.tryParse(json) ?? 0; // Fallback to 0 if parsing fails
  } else if (json is int) {
    return json;
  }
  throw Exception("Unexpected type");
}
