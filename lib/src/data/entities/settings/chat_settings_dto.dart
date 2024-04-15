import 'package:irllink/src/domain/entities/settings.dart';

import '../../../domain/entities/settings/chat_settings.dart';

class ChatSettingsDTO extends ChatSettings {
  const ChatSettingsDTO({
    required super.chatGroups,
    required super.hideDeletedMessages,
  });

  @override
  Map toJson() => {
        'chatGroups': chatGroups,
        'hideDeletedMessages': hideDeletedMessages,
      };

  factory ChatSettingsDTO.fromJson(Map<String, dynamic> map) {
    List<ChatGroup> gDto = [];
    map['chatGroups'].map((e) => gDto.add(ChatGroupDTO.fromJson(e)));

    return ChatSettingsDTO(
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
    map['channels'].map((e) => cDto.add(ChannelDTO.fromJson(e)));

    return ChatGroupDTO(
      id: map['channels'] ??
          const Settings.defaultSettings().chatSettings!.chatGroups.first.id,
      channels: cDto,
    );
  }
}

class ChannelDTO extends Channel {
  const ChannelDTO({
    required super.platform,
    required super.channel,
    required super.enabled,
  });

  factory ChannelDTO.fromJson(Map<String, dynamic> map) {
    return ChannelDTO(
      platform: map['channels'] ??
          const Settings.defaultSettings()
              .chatSettings!
              .chatGroups
              .first
              .channels
              .first
              .platform,
      channel: map['channels'] ??
          const Settings.defaultSettings()
              .chatSettings!
              .chatGroups
              .first
              .channels
              .first
              .channel,
      enabled: map['channels'] ??
          const Settings.defaultSettings()
              .chatSettings!
              .chatGroups
              .first
              .channels
              .first
              .enabled,
    );
  }
}
