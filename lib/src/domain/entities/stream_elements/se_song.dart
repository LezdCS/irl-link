import 'package:equatable/equatable.dart';

class SeSong extends Equatable {
  final String id;
  final String videoId;
  final String title;
  final String channel;
  final int duration;

  const SeSong({
    required this.id,
    required this.videoId,
    required this.title,
    required this.channel,
    required this.duration,
  });

  factory SeSong.fromJson(Map<String, dynamic> map) {
    return SeSong(
      id: map["_id"] ?? '',
      title: map["title"],
      videoId: map["videoId"],
      duration: map["duration"] ?? 0,
      channel: map["channel"],
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      videoId,
      title,
      channel,
      duration,
    ];
  }

  @override
  bool get stringify => true;
}
