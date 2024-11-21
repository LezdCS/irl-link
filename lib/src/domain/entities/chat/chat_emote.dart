import 'package:flutter/material.dart';
import 'package:twitch_chat/twitch_chat.dart' as twitch;

enum EmotePlateform {
  twitch,
  kick,
}

@immutable
class ChatEmote {
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

  factory ChatEmote.fromKick(Map<String, dynamic> map) {
    String url = map['data']['host']['url'];
    url = url.substring(2);
    List webpfNames = (map['data']['host']['files'] as List)
        .where((element) => element['format'] == "WEBP")
        .toList();

    String url1x = 'https://$url/${webpfNames[0]['name']}';
    String url2x = 'https://$url/${webpfNames[1]['name']}';
    String url4x = 'https://$url/${webpfNames[2]['name']}';
    return ChatEmote(
      id: map["id"].toString(),
      name: map["name"],
      url1x: url1x,
      url2x: url2x,
      url4x: url4x,
      color: null,
      emoteType: twitch.EmoteType.thirdPart,
      plateform: EmotePlateform.kick,
    );
  }
}
