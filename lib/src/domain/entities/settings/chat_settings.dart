import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';

@immutable
class ChatSettings {
  final ChatGroup permanentFirstGroup;
  final List<ChatGroup> chatGroups;
  final bool hideDeletedMessages;

  const ChatSettings({
    required this.permanentFirstGroup,
    required this.chatGroups,
    required this.hideDeletedMessages,
  });

  ChatSettings copyWith({
    ChatGroup? permanentFirstGroup,
    List<ChatGroup>? chatGroups,
    bool? hideDeletedMessages,
  }) {
    return ChatSettings(
      permanentFirstGroup: permanentFirstGroup ?? this.permanentFirstGroup,
      chatGroups: chatGroups ?? this.chatGroups,
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
  final bool enabled;

  const Channel({
    required this.platform,
    required this.channel,
    required this.enabled,
  });
}
