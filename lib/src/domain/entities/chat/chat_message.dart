import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
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

// ignore: must_be_immutable
class ChatMessage extends Equatable
    implements
        twitch.Subscription,
        twitch.SubGift,
        twitch.BitDonation,
        twitch.IncomingRaid {
  @override
  final String id;
  @override
  final String authorId;
  @override
  final String username;
  @override
  final String color;
  @override
  final String message;
  @override
  final int timestamp;
  @override
  final bool isAction;
  @override
  final bool isSubscriber;
  @override
  final bool isModerator;
  @override
  final bool isVip;
  @override
  bool isDeleted;
  @override
  final String rawData;

  final String channelId;
  final EventType? eventType;
  final List<ChatBadge> badgesList;
  @override
  final Map<String, List> emotes; //TODO: emote entity
  final Platform platform;

  ChatMessage({
    required this.id,
    required this.authorId,
    required this.username,
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
    required this.badges,
    required this.displayName,
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
      badges: message.badges,
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
      KickMessage message, String channelId, List<KickBadge> subBadges) {
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
      badges: const [],
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
      dynamic messageRaw, List? messages, String videoId) {
    String authorName = messageRaw['authorName']['simpleText'];
    String id = messageRaw['id'];
    String timestamp = messageRaw['timestampUsec'];
    return ChatMessage(
      id: id,
      authorId: '',
      displayName: authorName,
      username: authorName,
      color: '#FFFFFF',
      message: messages?[0],
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
      channelId: videoId,

      //implements
      raidingChannelName: '',
      badges: const [],
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
      KickSubscription sub, String channelId, List<KickBadge> subBadges) {
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
      badges: const [],
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

  factory ChatMessage.kickSubGift(KickGiftedSubscriptions sub, String channelId,
      List<KickBadge> subBadges) {
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
      badges: const [],
      giftedName: sub
          .data.giftedUsernames.first, //TODO: handle multiple usernames gifted
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
      KickStreamHost host, String channelId, List<KickBadge> subBadges) {
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
      badges: const [],
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

  Map toJson() => {
        'id': id,
        'authorId': authorId,
        'displayName': displayName,
        'username': username,
        'color': color,
        'message': message,
        'timestamp': timestamp,
        'isAction': isAction,
        'isSubscriber': isSubscriber,
        'isModerator': isModerator,
        'isVip': isVip,
        'isDeleted': isDeleted,
        'rawData': rawData,
        'eventType': eventType,
        'badgesList': badgesList,
        'emotes': emotes,
        'platform': platform,
      };

  Map toJsonForWatch() => {
        'id': id == '' ? const Uuid().v4() : id,
        'username': username == '' ? displayName : username,
        'message': message,
        'color': color == '' ? '#FFFFFF' : color,
        'badges': jsonEncode(
          badgesList.map((badge) => badge.imageUrl1x.startsWith('http') ? badge.imageUrl1x : '').toList(),
        ),
      };

  @override
  List<Object?> get props {
    return [
      id,
      authorId,
      displayName,
      username,
      color,
      message,
      timestamp,
      isAction,
      isSubscriber,
      isModerator,
      isVip,
      isDeleted,
      rawData,
      eventType,
      badgesList,
      emotes,
      platform,
    ];
  }

  @override
  bool get stringify => true;

  @override
  String raidingChannelName;

  @override
  List<twitch.TwitchBadge> badges;

  @override
  String displayName;

  @override
  String giftedName;

  @override
  twitch.HighlightType? highlightType;

  @override
  bool isGift;

  @override
  String months;

  @override
  String systemMessage;

  @override
  String tier;

  @override
  int totalBits;

  @override
  int viewerCount;

  @override
  set rawData(String rawData) {
    // TODO: implement rawData
  }
}
