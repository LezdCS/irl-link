import 'package:equatable/equatable.dart';
import 'package:kick_chat/kick_chat.dart';
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

  factory ChatBadge.fromKick(
      String channelId, UserBadge badge, List<KickBadge> subBadges) {
    String src = '';
    switch (badge.type) {
      case 'subscriber':
      src= subBadges.lastWhere((element) => badge.count >= element.months).badgeImage.src;
        break;
      case 'vip':
        src = './lib/assets/kick/vip.svg';
        break;
      case 'og':
        src = './lib/assets/kick/og.svg';
        break;
      case 'founder':
        src = './lib/assets/kick/founder.svg';
        break;
      case 'verified':
        src = './lib/assets/kick/verified.svg';
        break;
      case 'moderator':
        src = './lib/assets/kick/moderator.svg';
        break;
      case 'sub_gifter':
        src = './lib/assets/kick/sub_gifter.svg';
        break;
    }

    KickBadge correspondingBadge = KickBadge(
      id: 0,
      channelId: int.parse(channelId),
      months: 0,
      badgeImage: BadgeImage(src: src),
    );
    return ChatBadge(
      id: correspondingBadge.id.toString(),
      imageUrl1x: correspondingBadge.badgeImage.src,
      imageUrl2x: correspondingBadge.badgeImage.src,
      imageUrl4x: correspondingBadge.badgeImage.src,
    );
  }

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
