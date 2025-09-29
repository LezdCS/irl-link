import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/settings/chat_events_settings.dart';

@immutable
class Settings {
  //CHAT SETTINGS
  final ChatEventsSettings chatEventsSettings;

  const Settings({
    //CHAT SETTINGS
    required this.chatEventsSettings,
  });

  Settings copyWith({
    //CHAT
    ChatEventsSettings? chatEventsSettings,
  }) =>
      Settings(
        //CHAT
        chatEventsSettings: chatEventsSettings ?? this.chatEventsSettings,
      );
}
