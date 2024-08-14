import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';

class ChatSettingsDTO extends ChatSettings {
  const ChatSettingsDTO({
    required super.permanentFirstGroup,
    required super.chatGroups,
    required super.hideDeletedMessages,
  });

  @override
  Map toJson() => {
        'permanentFirstGroup': permanentFirstGroup.toJson(),
        'chatGroups': chatGroups.map((e) => e.toJson()).toList(),
        'hideDeletedMessages': hideDeletedMessages,
      };

  factory ChatSettingsDTO.fromJson(Map<String, dynamic> map) {
    List<ChatGroup> gDto = [];
    for (dynamic chatGroup in map['chatGroups'] ?? []) {
      gDto.add(ChatGroupDTO.fromJson(chatGroup));
    }

    ChatGroup? permanentFirstGroup;

    if (map['permanentFirstGroup'] is ChatGroup) {
      permanentFirstGroup = map['permanentFirstGroup'];
    } else {
      permanentFirstGroup = ChatGroupDTO.fromJson(
        map['permanentFirstGroup'] ??
            const Settings.defaultSettings().chatSettings!.permanentFirstGroup,
      );
    }

    return ChatSettingsDTO(
      permanentFirstGroup: permanentFirstGroup ??
          const Settings.defaultSettings().chatSettings!.permanentFirstGroup,
      chatGroups: gDto,
      hideDeletedMessages: map['hideDeletedMessages'] ??
          const Settings.defaultSettings().chatSettings!.hideDeletedMessages,
    );
  }
}

class ChatGroupDTO extends ChatGroup {
  const ChatGroupDTO({
    required super.id,
    required super.channels,
  });

  factory ChatGroupDTO.fromJson(Map<String, dynamic> map) {
    List<Channel> cDto = [];
    for (dynamic channel in map['channels'] ?? []) {
      cDto.add(ChannelDTO.fromJson(channel));
    }

    return ChatGroupDTO(
      id: map['id'] ??
          const Settings.defaultSettings().chatSettings!.chatGroups.first.id,
      channels: cDto,
    );
  }

  @override
  Map toJson() => {
        'id': id,
        'channels': channels.map((e) => e.toJson()).toList(),
      };
}

class ChannelDTO extends Channel {
  const ChannelDTO({
    required super.platform,
    required super.channel,
    required super.enabled,
  });

  factory ChannelDTO.fromJson(Map<String, dynamic> map) {
    return ChannelDTO(
      platform: getPlatformFromString(
        map['platform'] ??
            const Settings.defaultSettings()
                .chatSettings!
                .chatGroups
                .first
                .channels
                .first
                .platform,
      ),
      channel: map['channel'] ??
          const Settings.defaultSettings()
              .chatSettings!
              .chatGroups
              .first
              .channels
              .first
              .channel,
      enabled: map['enabled'] ??
          const Settings.defaultSettings()
              .chatSettings!
              .chatGroups
              .first
              .channels
              .first
              .enabled,
    );
  }

  @override
  Map toJson() => {
        'platform': platform.name.toString(),
        'channel': channel,
        'enabled': enabled,
      };
}

Platform getPlatformFromString(String platformAsString) {
  for (Platform element in Platform.values) {
    if (element.name == platformAsString) {
      return element;
    }
  }
  throw Exception('Platform not found');
}
