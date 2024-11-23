import 'package:flutter/material.dart';

@immutable
class TwitchDecodedIdToken {
  final String preferredUsername;
  final String profilePicture;

  const TwitchDecodedIdToken({
    required this.preferredUsername,
    required this.profilePicture,
  });
}
