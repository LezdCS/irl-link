import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class Rtmp {
  final int id;
  final String name;
  final String url;
  final String key;
  final DateTime createdAt;

  const Rtmp({
    required this.id,
    required this.name,
    required this.url,
    required this.key,
    required this.createdAt,
  });
}
