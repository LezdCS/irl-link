import 'package:flutter/material.dart';

@immutable
class SeMe {
  final String id;
  final String avatar;
  final String username;
  final String displayName;

  const SeMe({
    required this.id,
    required this.avatar,
    required this.username,
    required this.displayName,
  });
}
