import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:irllink/src/domain/entities/chat/chat_badge.dart';
import 'package:kick_chat/kick_chat.dart';
import 'package:twitch_chat/twitch_chat.dart' as twitch;

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
}

// ignore: must_be_immutable
class ChatMessage extends Equatable implements twitch.Subscription, twitch.SubGift, twitch.BitDonation, twitch.IncomingRaid {
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

  final EventType? eventType;
  final List<ChatBadge> badgesList;
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

  factory ChatMessage.fromTwitch(twitch.ChatMessage message) {

    EventType? type = EventType.values.firstWhereOrNull(
        (e) => e.toString().split('.').last == message.highlightType.toString().split('.').last,
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
      badgesList: message.badges.map((badge) => ChatBadge.fromTwitch(badge)).toList(),
      emotes: message.emotes,
      platform: Platform.twitch,

      //implements
      raidingChannelName: type == EventType.incomingRaid ? (message as twitch.IncomingRaid).raidingChannelName : '',
      badges: message.badges,
      giftedName: type == EventType.subscriptionGifted ? (message as twitch.SubGift).giftedName : '',
      highlightType: message.highlightType,
      isGift: type == EventType.subscriptionGifted,
      months: type == EventType.subscription ? (message as twitch.Subscription).months : '',
      systemMessage: type == EventType.subscriptionGifted ? (message as twitch.SubGift).systemMessage : '',
      tier: type == EventType.subscription ? (message as twitch.Subscription).tier : '',
      totalBits: type == EventType.bitDonation ? (message as twitch.BitDonation).totalBits : 0,
      viewerCount: type == EventType.incomingRaid ? (message as twitch.IncomingRaid).viewerCount : 0,
    );
  }

  factory ChatMessage.fromKick(KickMessage message) {
    return ChatMessage(
      id: message.data.id,
      authorId: message.data.sender.id.toString(),
      displayName: message.data.sender.username,
      username: message.data.sender.username,
      color: message.data.sender.identity.color,
      message: message.data.content,
      timestamp: int.parse(message.data.createdAt),
      isAction: false,
      isSubscriber: false,
      isModerator: false,
      isVip: false,
      isDeleted: false,
      rawData: '',
      eventType: null, //TODO: Add event type for KickMessage
      badgesList: const [], //TODO: Add badges for KickMessage
      emotes: const {}, //TODO: Add emotes for KickMessage
      platform: Platform.kick,

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
  set rawData(String _rawData) {
    // TODO: implement rawData
  }
  
}
