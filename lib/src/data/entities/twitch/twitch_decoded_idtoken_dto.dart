
import 'package:irllink/src/domain/entities/twitch/twitch_decoded_idtoken.dart';

class TwitchDecodedIdTokenDTO extends TwitchDecodedIdToken {
  const TwitchDecodedIdTokenDTO({
    required String preferredUsername,
    required String profilePicture,
  }) : super(
          preferredUsername: preferredUsername,
          profilePicture: profilePicture,
        );

  @override
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
