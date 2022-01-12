import 'package:equatable/equatable.dart';

enum EmoteType {
  global,
  follower,
  subscriptions,
  bitsTier,
  thirdPart,
  cheer,
}

class Emote extends Equatable {
  final String id;
  final String name;
  final String url1x;
  final String url2x;
  final String url4x;
  final String? color;
  final EmoteType emoteType;

  const Emote({
    required this.id,
    required this.name,
    required this.url1x,
    required this.url2x,
    required this.url4x,
    required this.color,
    required this.emoteType,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      url1x,
      url2x,
      url4x,
      color,
      emoteType,
    ];
  }

  @override
  bool get stringify => true;
}
