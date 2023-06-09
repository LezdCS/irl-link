import 'package:irllink/src/domain/entities/settings.dart';

import '../../../domain/entities/settings/chat_settings.dart';

class ChatSettingsDTO extends ChatSettings {
  const ChatSettingsDTO({
    required List chatsJoined,
    required bool joinMyself,
  }) : super(
    chatsJoined: chatsJoined,
    joinMyself: joinMyself,
  );

  Map toJson() => {
    'chatsJoined': chatsJoined,
    'joinMyself': joinMyself,
  };

  factory ChatSettingsDTO.fromJson(Map<String, dynamic> map) {
    return ChatSettingsDTO(
      chatsJoined: map['chatsJoined'] ??
          Settings.defaultSettings().chatSettings!.chatsJoined,
      joinMyself: map['joinMyself'] ??
          Settings.defaultSettings().chatSettings!.joinMyself,
    );
  }
}
