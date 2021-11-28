import 'package:irllink/src/domain/entities/emote.dart';

class EmoteDTO extends Emote {
  const EmoteDTO({
    required String id,
    required String name,
    required String url1x,
    required String url2x,
    required String url4x,
    required EmoteType emoteType,
  }) : super(
          id: id,
          name: name,
          url1x: url1x,
          url2x: url2x,
          url4x: url4x,
          emoteType: emoteType,
        );

  factory EmoteDTO.fromJson(Map<String, dynamic> map, EmoteType emoteType) {
    return EmoteDTO(
      id: map['id'] as String,
      name: map['name'] as String,
      url1x: map['images']['url_1x'] as String,
      url2x: map['images']['url_2x'] as String,
      url4x: map['images']['url_4x'] as String,
      emoteType: emoteType,
    );
  }
}
