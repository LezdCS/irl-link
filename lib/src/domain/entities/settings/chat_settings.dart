
import 'package:irllink/src/domain/entities/chat/chat_message.dart';

class ChatSettings {
  final ChatGroup permanentFirstGroup;
  final List<ChatGroup> chatGroups;
  final bool hideDeletedMessages;

  const ChatSettings({
    required this.permanentFirstGroup,
    required this.chatGroups,
    required this.hideDeletedMessages,
  });

  Map toJson() => {
        'permanentFirstGroup': permanentFirstGroup.toJson(),
        'chatGroups': chatGroups.map((e) => e.toJson()).toList(),
        'hideDeletedMessages': hideDeletedMessages,
      };
  
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

  Map toJson() => {
        'id': id,
        'channels': channels.map((e) => e.toJson()).toList(),
      };

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

  Map toJson() => {
        'platform': platform.name.toString(),
        'channel': channel,
        'enabled': enabled,
      };
}
