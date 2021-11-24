import 'package:irllink/src/domain/entities/twitch_user.dart';

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

  Map toJson() => {
        'id': id,
        'login': login,
        'displayName': displayName,
        'broadcasterType': broadcasterType,
        'description': description,
        'profileImageUrl': profileImageUrl,
        'viewCount': viewCount,
      };

  factory TwitchUserDTO.fromJson(Map<String, dynamic> map) {
    return TwitchUserDTO(
      id: map['id'] as String,
      login: map['login'] as String,
      displayName: map['displayName'] as String,
      broadcasterType: map['broadcasterType'] as String,
      description: map['description'] as String,
      profileImageUrl: map['profileImageUrl'] as String,
      viewCount: map['viewCount'] as String,
    );
  }
}
