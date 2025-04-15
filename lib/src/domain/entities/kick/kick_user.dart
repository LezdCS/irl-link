import 'package:flutter/material.dart';

@immutable
class KickUser {
  final int userId;
  final String name;
  final String email;
  final String profilePicture;

  const KickUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.profilePicture,
  });
}
