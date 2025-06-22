import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';

@immutable
class ChatSettings {
  final bool hideDeletedMessages;

  const ChatSettings({
    required this.hideDeletedMessages,
  });

  ChatSettings copyWith({
    bool? hideDeletedMessages,
  }) {
    return ChatSettings(
      hideDeletedMessages: hideDeletedMessages ?? this.hideDeletedMessages,
    );
  }
}

class ChatGroup {
  final String id;
  final List<Channel> channels;

  const ChatGroup({
    required this.id,
    required this.channels,
  });

  ChatGroup copyWith({
    String? id,
    List<Channel>? channels,
  }) {
    return ChatGroup(
      id: id ?? this.id,
      channels: channels ?? this.channels,
    );
  }
}

class Channel {
  final Platform platform;
  final String channel;

  const Channel({
    required this.platform,
    required this.channel,
  });
}
