import 'package:irllink/src/domain/entities/twitch_badge.dart';

class TwitchBadgeDTO extends TwitchBadge {
  const TwitchBadgeDTO({
    required String setId,
    required String versionId,
    required String imageUrl1x,
    required String imageUrl2x,
    required String imageUrl4x,
  }) : super(
          setId: setId,
          versionId: versionId,
          imageUrl1x: imageUrl1x,
          imageUrl2x: imageUrl2x,
          imageUrl4x: imageUrl4x,
        );

  Map toJson() => {
        'setId': setId,
        'versionId': versionId,
        'imageUrl1x': imageUrl1x,
        'imageUrl2x': imageUrl2x,
        'imageUrl4x': imageUrl4x,
      };

  factory TwitchBadgeDTO.fromJson(String setId, Map<String, dynamic> map) {
    return TwitchBadgeDTO(
      setId: setId,
      versionId: map['id'] as String,
      imageUrl1x: map['image_url_1x'] as String,
      imageUrl2x: map['image_url_2x'] as String,
      imageUrl4x: map['image_url_4x'] as String,
    );
  }
}
