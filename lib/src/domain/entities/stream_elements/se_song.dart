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
