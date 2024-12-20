import 'package:flutter/material.dart';

@immutable
class TwitchUser {
  final String id;
  final String login;
  final String displayName;
  final String broadcasterType;
  final String description;
  final String profileImageUrl;
  final int viewCount;

  const TwitchUser({
    required this.id,
    required this.login,
    required this.displayName,
    required this.broadcasterType,
    required this.description,
    required this.profileImageUrl,
    required this.viewCount,
  });
}
