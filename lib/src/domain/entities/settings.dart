import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/settings/chat_events_settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/settings/general_settings.dart';

@immutable
class Settings {
  //CHAT SETTINGS
  final ChatEventsSettings chatEventsSettings;
  final ChatSettings chatSettings;

  //GENERAL SETTINGS
  final GeneralSettings generalSettings;

  const Settings({
    //CHAT SETTINGS
    required this.chatEventsSettings,
    required this.chatSettings,

    //GENERAL SETTINGS
    required this.generalSettings,
  });

  Settings copyWith({
    //CHAT
    ChatEventsSettings? chatEventsSettings,
    ChatSettings? chatSettings,
    //GENERAL
    GeneralSettings? generalSettings,
  }) =>
      Settings(
        //CHAT
        chatEventsSettings: chatEventsSettings ?? this.chatEventsSettings,
        chatSettings: chatSettings ?? this.chatSettings,
        //GENERAL
        generalSettings: generalSettings ?? this.generalSettings,
      );
}
