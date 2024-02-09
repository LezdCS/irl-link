
import 'package:irllink/src/domain/entities/twitch/twitch_user.dart';

class TwitchUserDTO extends TwitchUser {
  const TwitchUserDTO({
    required String id,
    required String login,
    required String displayName,
    required String broadcasterType,
    required String description,
    required String profileImageUrl,
    required String viewCount,
  }) : super(
          id: id,
          login: login,
          displayName: displayName,
          broadcasterType: broadcasterType,
          description: description,
          profileImageUrl: profileImageUrl,
          viewCount: viewCount,
        );

  @override
  Map toJson() => {
        'id': id,
        'login': login,
        'display_name': displayName,
        'broadcaster_type': broadcasterType,
        'description': description,
        'profile_image_url': profileImageUrl,
        'view_count': viewCount,
      };

  factory TwitchUserDTO.fromJson(Map<String, dynamic> map) {
    return TwitchUserDTO(
      id: map['id'] as String,
      login: map['login'] as String,
      displayName: map['display_name'] as String,
      broadcasterType: map['broadcaster_type'] as String,
      description: map['description'] as String,
      profileImageUrl: map['profile_image_url'] as String,
      viewCount: map['view_count'].toString(),
    );
  }
}
