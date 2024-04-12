import 'package:equatable/equatable.dart';
import 'package:twitch_chat/twitch_chat.dart' as twitch;

enum EmotePlateform {
  twitch,
  kick,
}

class ChatEmote extends Equatable {
  final String id;
  final String name;
  final String url1x;
  final String url2x;
  final String url4x;
  final String? color;
  final twitch.EmoteType emoteType;
  final EmotePlateform plateform;

  const ChatEmote({
    required this.id,
    required this.name,
    required this.url1x,
    required this.url2x,
    required this.url4x,
    required this.color,
    required this.emoteType,
    required this.plateform,
  });

  factory ChatEmote.fromTwitch(twitch.Emote emote) {
    return ChatEmote(
      id: emote.id,
      name: emote.name,
      url1x: emote.url1x,
      url2x: emote.url2x,
      url4x: emote.url4x,
      color: emote.color,
      emoteType: emote.emoteType,
      plateform: EmotePlateform.twitch,
    );
  }

  // factory ChatEmote.fromKick(KickBadge badge) {
  //   return ChatEmote(
  //     id: badge.id,
  //   );
  // }

  Map toJson() => {
        'id': id,
        'name': name,
        'url1x': url1x,
        'url2x': url2x,
        'url4x': url4x,
        'color': color,
        'emoteType': emoteType,
      };

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
