import 'package:flutter/material.dart';

@immutable
class KickCategory {
  final int id;
  final String name;
  final String thumbnail;

  const KickCategory({
    required this.id,
    required this.name,
    required this.thumbnail,
  });
}
