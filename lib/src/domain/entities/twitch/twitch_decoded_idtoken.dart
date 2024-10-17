class TwitchDecodedIdToken {
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
}
