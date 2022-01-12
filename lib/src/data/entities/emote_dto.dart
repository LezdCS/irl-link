import 'package:irllink/src/domain/entities/emote.dart';

class EmoteDTO extends Emote {
  const EmoteDTO({
    required String id,
    required String name,
    required String url1x,
    required String url2x,
    required String url4x,
    required String? color,
    required EmoteType emoteType,
  }) : super(
          id: id,
          name: name,
          url1x: url1x,
          url2x: url2x,
          url4x: url4x,
          color: color,
          emoteType: emoteType,
        );

  factory EmoteDTO.fromJson(Map<String, dynamic> map) {
    EmoteType emoteType = EmoteType.global;
    if (map['emote_type'] != null) {
      switch (map['emote_type']) {
        case "subscriptions":
          emoteType = EmoteType.subscriptions;
          break;
        case "follower":
          emoteType = EmoteType.follower;
          break;
        case "bitstier":
          emoteType = EmoteType.bitsTier;
          break;
      }
    }

    return EmoteDTO(
      id: map['id'] as String,
      name: map['name'] as String,
      url1x: map['images']['url_1x'] as String,
      url2x: map['images']['url_2x'] as String,
      url4x: map['images']['url_4x'] as String,
      color: null,
      emoteType: emoteType,
    );
  }

  factory EmoteDTO.fromJsonCheerEmotes(
      Map<String, dynamic> map, String prefix) {
    return EmoteDTO(
      id: map["id"],
      name: prefix + map["id"],
      url1x: map['images']['dark']['animated']["1"] as String,
      url2x: map['images']['dark']['animated']["2"] as String,
      url4x: map['images']['dark']['animated']["4"] as String,
      color: map["color"] as String,
      emoteType: EmoteType.cheer,
    );
  }
}
