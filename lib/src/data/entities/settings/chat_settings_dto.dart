import 'package:irllink/src/domain/entities/settings.dart';

import '../../../domain/entities/settings/chat_settings.dart';

class ChatSettingsDTO extends ChatSettings {
  const ChatSettingsDTO({
    required super.chatsJoined,
    required super.joinMyself,
    required super.hideDeletedMessages,
  });

  @override
  Map toJson() => {
        'chatsJoined': chatsJoined,
        'joinMyself': joinMyself,
        'hideDeletedMessages': hideDeletedMessages,
      };

  factory ChatSettingsDTO.fromJson(Map<String, dynamic> map) {
    return ChatSettingsDTO(
      chatsJoined: map['chatsJoined'] ??
          const Settings.defaultSettings().chatSettings!.chatsJoined,
      joinMyself: map['joinMyself'] ??
          const Settings.defaultSettings().chatSettings!.joinMyself,
      hideDeletedMessages: map['hideDeletedMessages'] ??
          const Settings.defaultSettings().chatSettings!.hideDeletedMessages,
    );
  }
}
