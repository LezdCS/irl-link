import 'package:equatable/equatable.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';

class ChatSettings extends Equatable {
  final List<ChatGroup> chatGroups;
  final bool hideDeletedMessages;

  const ChatSettings({
    required this.chatGroups,
    required this.hideDeletedMessages,
  });

  @override
  List<Object?> get props {
    return [
      chatGroups,
      hideDeletedMessages,
    ];
  }

  Map toJson() => {
        'chatGroups': chatGroups,
        'hideDeletedMessages': hideDeletedMessages,
      };

  @override
  bool get stringify => true;

  ChatSettings copyWith({
    List<ChatGroup>? chatGroups,
    bool? hideDeletedMessages,
  }) {
    return ChatSettings(
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
        'channels': channels,
      };
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
        'platform': platform,
        'channel': channel,
        'enabled': enabled,
      };
}
