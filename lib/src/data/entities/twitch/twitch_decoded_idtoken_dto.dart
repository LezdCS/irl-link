import 'package:irllink/src/domain/entities/twitch/twitch_decoded_idtoken.dart';

class TwitchDecodedIdTokenDTO extends TwitchDecodedIdToken {
  const TwitchDecodedIdTokenDTO({
    required super.preferredUsername,
    required super.profilePicture,
  });

  Map toJson() => {
        'preferredUsername': preferredUsername,
        'profilePicture': profilePicture,
      };

  factory TwitchDecodedIdTokenDTO.fromJson(Map<String, dynamic> map) {
    return TwitchDecodedIdTokenDTO(
      preferredUsername: map['preferredUsername'] as String,
      profilePicture: map['profilePicture'] as String,
    );
  }
}
