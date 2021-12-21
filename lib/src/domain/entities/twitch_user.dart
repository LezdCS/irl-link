import 'package:equatable/equatable.dart';

class TwitchUser extends Equatable {
  final String id;
  final String login;
  final String displayName;
  final String broadcasterType;
  final String description;
  final String profileImageUrl;
  final String viewCount;

  const TwitchUser({
    required this.id,
    required this.login,
    required this.displayName,
    required this.broadcasterType,
    required this.description,
    required this.profileImageUrl,
    required this.viewCount,
  });

  Map toJson() => {
        'id': id,
        'login': login,
        'display_name': displayName,
        'broadcaster_type': broadcasterType,
        'description': description,
        'profile_image_url': profileImageUrl,
        'view_count': viewCount,
      };

  @override
  List<Object?> get props {
    return [
      id,
      login,
      displayName,
      broadcasterType,
      description,
      profileImageUrl,
      viewCount,
    ];
  }

  @override
  bool get stringify => true;
}
