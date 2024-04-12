import 'package:equatable/equatable.dart';
import 'package:twitch_chat/twitch_chat.dart' as twitch;

class ChatBadge extends Equatable {
  final String id;
  final String imageUrl1x;
  final String imageUrl2x;
  final String imageUrl4x;

  const ChatBadge({
    required this.id,
    required this.imageUrl1x,
    required this.imageUrl2x,
    required this.imageUrl4x,
  });

  factory ChatBadge.fromTwitch(twitch.TwitchBadge badge) {
    return ChatBadge(
      id: '${badge.setId} - ${badge.versionId}',
      imageUrl1x: badge.imageUrl1x,
      imageUrl2x: badge.imageUrl2x,
      imageUrl4x: badge.imageUrl4x,
    );
  }

  // factory ChatBadge.fromKick(KickBadge badge) {
  //   return ChatBadge(
  //     id: badge.id,
  //   );
  // }

  Map toJson() => {
        'id': id,
        'imageUrl1x': imageUrl1x,
        'imageUrl2x': imageUrl2x,
        'imageUrl4x': imageUrl4x,
      };

  @override
  List<Object?> get props {
    return [
      id,
      imageUrl1x,
      imageUrl2x,
      imageUrl4x,
    ];
  }

  @override
  bool get stringify => true;
}
