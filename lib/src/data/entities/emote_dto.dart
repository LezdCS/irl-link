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
    required bool isZeroWidth,
  }) : super(
          id: id,
          name: name,
          url1x: url1x,
          url2x: url2x,
          url4x: url4x,
          color: color,
          emoteType: emoteType,
          isZeroWidth: isZeroWidth,
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
      isZeroWidth: false,
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
      isZeroWidth: false,
    );
  }

  factory EmoteDTO.fromJsonFrankerfacez(Map<String, dynamic> map) {
    return EmoteDTO(
      id: map["id"].toString(),
      name: map["name"],
      url1x: "https:" + map['urls']['1'],
      url2x: map['urls']['2'] != null ? "https:" + map['urls']['2'] : "",
      url4x: map['urls']['4'] != null ? "https:" + map['urls']['4'] : "",
      color: null,
      emoteType: EmoteType.thirdPart,
      isZeroWidth: false,
    );
  }

  factory EmoteDTO.fromJsonBttv(Map<String, dynamic> map) {
    return EmoteDTO(
      id: map["id"],
      name: map["code"],
      url1x: "https://cdn.betterttv.net/emote/" + map['id'] + "/1x",
      url2x: "https://cdn.betterttv.net/emote/" + map['id'] + "/2x",
      url4x: "https://cdn.betterttv.net/emote/" + map['id'] + "/3x",
      color: null,
      emoteType: EmoteType.thirdPart,
      isZeroWidth: false,
    );
  }

  factory EmoteDTO.fromJson7Tv(Map<String, dynamic> map) {
    return EmoteDTO(
      id: map["id"].toString(),
      name: map["name"],
      url1x: map['urls'][0][1].toString(),
      url2x: map['urls'][1][1].toString(),
      url4x: map['urls'][2][1].toString(),
      color: null,
      emoteType: EmoteType.thirdPart,
      isZeroWidth:
          map['visibility_simple'].contains("ZERO_WIDTH") ? true : false,
    );
  }
}
