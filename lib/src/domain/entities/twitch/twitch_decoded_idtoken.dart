import 'package:equatable/equatable.dart';

class TwitchDecodedIdToken extends Equatable {
  final String preferredUsername;
  final String profilePicture;

  const TwitchDecodedIdToken({
    required this.preferredUsername,
    required this.profilePicture,
  });

  Map toJson() => {
        'preferredUsername': preferredUsername,
        'profilePicture': profilePicture,
      };

  @override
  List<Object?> get props {
    return [
      preferredUsername,
      profilePicture,
    ];
  }

  @override
  bool get stringify => true;
}
