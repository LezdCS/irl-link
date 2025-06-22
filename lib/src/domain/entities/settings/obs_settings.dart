import 'package:flutter/material.dart';

@immutable
class ObsSettings {
  final String url;
  final String password;
  final bool isConnected;

  const ObsSettings({
    required this.url,
    required this.password,
    required this.isConnected,
  });
}
