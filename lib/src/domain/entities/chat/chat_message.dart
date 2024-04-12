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
class ChatMessage extends Equatable {
  final String id;
  final String authorId;
  final String authorName;
  final String username;
  final String color;
  final String message;
  final int timestamp;
  final bool isAction;
  final bool isSubscriber;
  final bool isModerator;
  final bool isVip;
  bool isDeleted;
  final String rawData;
  final EventType? eventType;
  final List<ChatBadge> badges;
  final Map<String, List> emotes; //TODO: emote entity
  final Platform platform;

  ChatMessage({
    required this.id,
    required this.authorId,
    required this.authorName,
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
    required this.badges,
    required this.emotes,
    required this.platform,
  });

  factory ChatMessage.fromTwitch(twitch.ChatMessage message) {
    return ChatMessage(
      id: message.id,
      authorId: message.authorId,
      authorName: message.displayName,
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
      eventType: EventType.values.firstWhereOrNull(
        (e) => e.toString().split('.').last == message.highlightType.toString().split('.').last,
      ),
      badges: message.badges.map((badge) => ChatBadge.fromTwitch(badge)).toList(),
      emotes: message.emotes,
      platform: Platform.twitch,
    );
  }

  factory ChatMessage.fromKick(KickMessage message) {
    return ChatMessage(
      id: message.data.id,
      authorId: message.data.sender.id.toString(),
      authorName: message.data.sender.username,
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
      badges: const [], //TODO: Add badges for KickMessage
      emotes: const {}, //TODO: Add emotes for KickMessage
      platform: Platform.kick,
    );
  }

  Map toJson() => {
        'id': id,
        'authorId': authorId,
        'authorName': authorName,
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
        'badges': badges,
        'emotes': emotes,
        'platform': platform,
      };

  @override
  List<Object?> get props {
    return [
      id,
      authorId,
      authorName,
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
      badges,
      emotes,
      platform,
    ];
  }

  @override
  bool get stringify => true;
}
