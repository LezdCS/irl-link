import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:irllink/src/core/utils/username_color.dart';
import 'package:irllink/src/domain/entities/chat/chat_badge.dart';
import 'package:kick_chat/kick_chat.dart';
import 'package:twitch_chat/twitch_chat.dart' as twitch;
import 'package:uuid/uuid.dart';

enum EventType {
  firstTimeChatter,
  subscription,
  subscriptionGifted,
  bitDonation,
  incomingRaid,
  channelPointRedemption,
  announcement,
  shoutout,
  follower,
}

enum Platform {
  twitch,
  kick,
  youtube,
}

class ChatMessage {
  final String id;
  final String authorId;
  final String username;
  final String displayName;
  final String color;
  final String message;
  final int timestamp;
  final bool isAction;
  final bool isSubscriber;
  final bool isModerator;
  final bool isVip;
  bool isDeleted;
  final String rawData;

  final String channelId;
  final EventType? eventType;
  final List<ChatBadge> badgesList;
  final Map<String, List> emotes;
  final Platform platform;

  //from Twitch Chat events (subs, bits, raids...)
  final String raidingChannelName;
  final String giftedName;
  final twitch.HighlightType? highlightType;
  final bool isGift;
  final String months;
  final String systemMessage;
  final String tier;
  final int totalBits;
  final int viewerCount;

  ChatMessage({
    required this.id,
    required this.authorId,
    required this.username,
    required this.displayName,
    required this.color,
    required this.message,
    required this.timestamp,
    required this.isAction,
    required this.isSubscriber,
    required this.isModerator,
    required this.isVip,
    required this.isDeleted,
    required this.rawData,
    required this.eventType,
    required this.channelId,
    required this.badgesList,
    required this.emotes,
    required this.platform,

    //implements
    required this.raidingChannelName,
    required this.giftedName,
    required this.highlightType,
    required this.isGift,
    required this.months,
    required this.systemMessage,
    required this.tier,
    required this.totalBits,
    required this.viewerCount,
  });

  factory ChatMessage.fromTwitch(twitch.ChatMessage message, String channelId) {
    EventType? type = EventType.values.firstWhereOrNull(
      (e) =>
          e.toString().split('.').last ==
          message.highlightType.toString().split('.').last,
    );
    return ChatMessage(
      id: message.id,
      authorId: message.authorId,
      displayName: message.displayName,
      username: message.username,
      color: message.color,
      message: message.message,
      timestamp: message.timestamp,
      isAction: message.isAction,
      isSubscriber: message.isSubscriber,
      isModerator: message.isModerator,
      isVip: message.isVip,
      isDeleted: false,
      rawData: message.rawData,
      eventType: type,
      badgesList:
          message.badges.map((badge) => ChatBadge.fromTwitch(badge)).toList(),
      emotes: message.emotes,
      platform: Platform.twitch,
      channelId: channelId,

      //implements
      raidingChannelName: type == EventType.incomingRaid
          ? (message as twitch.IncomingRaid).raidingChannelName
          : '',
      giftedName: type == EventType.subscriptionGifted
          ? (message as twitch.SubGift).giftedName
          : '',
      highlightType: message.highlightType,
      isGift: type == EventType.subscriptionGifted,
      months: type == EventType.subscription
          ? (message as twitch.Subscription).months
          : '',
      systemMessage: type == EventType.subscriptionGifted
          ? (message as twitch.SubGift).systemMessage
          : '',
      tier: type == EventType.subscription
          ? (message as twitch.Subscription).tier
          : '',
      totalBits: type == EventType.bitDonation
          ? (message as twitch.BitDonation).totalBits
          : 0,
      viewerCount: type == EventType.incomingRaid
          ? (message as twitch.IncomingRaid).viewerCount
          : 0,
    );
  }

  factory ChatMessage.fromKick(
    KickEvent message,
    String channelId,
    List<KickBadge> subBadges,
  ) {
    if (message.event == TypeEvent.subscriptionEvent) {
      return ChatMessage.kickSub(message as KickSubscription, channelId);
    } else if (message.event == TypeEvent.giftedSubscriptionsEvent) {
      return ChatMessage.kickSubGift(
        message as KickGiftedSubscriptions,
        channelId,
      );
    } else if (message.event == TypeEvent.streamHostEvent) {
      return ChatMessage.kickHost(message as KickStreamHost, channelId);
    }

    message = message as KickMessage;

    return ChatMessage(
      id: message.data.id,
      authorId: message.data.sender.id.toString(),
      displayName: message.data.sender.username,
      username: message.data.sender.username,
      color: message.data.sender.identity.color,
      message: message.data.content,
      timestamp: DateTime.now().toUtc().millisecondsSinceEpoch,
      isAction: false,
      isSubscriber: false,
      isModerator: false,
      isVip: false,
      isDeleted: false,
      rawData: '',
      eventType: null,
      badgesList: message.data.sender.identity.badges
          .map((badge) => ChatBadge.fromKick(channelId, badge, subBadges))
          .toList(),
      emotes: const {},
      platform: Platform.kick,
      channelId: channelId,

      //implements
      raidingChannelName: '',
      giftedName: '',
      highlightType: null,
      isGift: false,
      months: '',
      systemMessage: '',
      tier: '',
      totalBits: 0,
      viewerCount: 0,
    );
  }

  factory ChatMessage.fromYoutube(
    Map<dynamic, dynamic> data,
    String channelId,
  ) {
    String id = data['unique_message_id'];
    String authorName = data['author'];
    String message = data['message'];
    String timestamp = data['timestamp'];
    return ChatMessage(
      id: id,
      authorId: '',
      displayName: authorName,
      username: authorName,
      color: randomUsernameColor(authorName),
      message: message,
      timestamp: int.parse(timestamp),
      isAction: false,
      isSubscriber: false,
      isModerator: false,
      isVip: false,
      isDeleted: false,
      rawData: '',
      eventType: null,
      badgesList: const [],
      emotes: const {},
      platform: Platform.youtube,
      channelId: channelId,

      //implements
      raidingChannelName: '',
      giftedName: '',
      highlightType: null,
      isGift: false,
      months: '',
      systemMessage: '',
      tier: '',
      totalBits: 0,
      viewerCount: 0,
    );
  }

  factory ChatMessage.kickSub(
    KickSubscription sub,
    String channelId,
  ) {
    return ChatMessage(
      id: '',
      authorId: '',
      displayName: sub.data.username,
      username: sub.data.username,
      color: '',
      message: '',
      timestamp: DateTime.now().toUtc().millisecondsSinceEpoch,
      isAction: false,
      isSubscriber: false,
      isModerator: false,
      isVip: false,
      isDeleted: false,
      rawData: '',
      eventType: EventType.subscription,
      badgesList: const [],
      emotes: const {},
      platform: Platform.kick,
      channelId: channelId,

      //implements
      raidingChannelName: '',
      giftedName: '',
      highlightType: null,
      isGift: false,
      months: sub.data.months.toString(),
      systemMessage: '',
      tier: '',
      totalBits: 0,
      viewerCount: 0,
    );
  }

  factory ChatMessage.kickSubGift(
    KickGiftedSubscriptions sub,
    String channelId,
  ) {
    return ChatMessage(
      id: '',
      authorId: '',
      displayName: sub.data.gifterUsername,
      username: sub.data.gifterUsername,
      color: '',
      message: '',
      timestamp: DateTime.now().toUtc().millisecondsSinceEpoch,
      isAction: false,
      isSubscriber: false,
      isModerator: false,
      isVip: false,
      isDeleted: false,
      rawData: '',
      eventType: EventType.subscriptionGifted,
      badgesList: const [],
      emotes: const {},
      platform: Platform.kick,
      channelId: channelId,

      //implements
      raidingChannelName: '',
      giftedName: sub.data.giftedUsernames
          .first, // TODO(LezdCS): Handle multiple usernames gifted
      highlightType: null,
      isGift: true,
      months: '',
      systemMessage: '',
      tier: '',
      totalBits: 0,
      viewerCount: 0,
    );
  }

  factory ChatMessage.kickHost(
    KickStreamHost host,
    String channelId,
  ) {
    return ChatMessage(
      id: '',
      authorId: '',
      displayName: host.data.hostUsername,
      username: host.data.hostUsername,
      color: '',
      message: host.data.optionalMessage,
      timestamp: DateTime.now().toUtc().millisecondsSinceEpoch,
      isAction: false,
      isSubscriber: false,
      isModerator: false,
      isVip: false,
      isDeleted: false,
      rawData: '',
      eventType: EventType.incomingRaid,
      badgesList: const [],
      emotes: const {},
      platform: Platform.kick,
      channelId: channelId,

      //implements
      raidingChannelName: '',
      giftedName: '',
      highlightType: null,
      isGift: true,
      months: '',
      systemMessage: '',
      tier: '',
      totalBits: 0,
      viewerCount: host.data.numberViewers,
    );
  }

  // factory ChatMessage.kickPinnedMessage(KickPinnedMessage pin, String channelId, List<KickBadges> subBadges){

  // }

  Map toJsonForWatch() => {
        'id': id == '' ? const Uuid().v4() : id,
        'username': username == '' ? displayName : username,
        'message': message,
        'color': color == '' ? '#FFFFFF' : color,
        'badges': jsonEncode(
          badgesList
              .map(
                (badge) =>
                    badge.imageUrl1x.startsWith('http') ? badge.imageUrl1x : '',
              )
              .toList(),
        ),
      };
}
