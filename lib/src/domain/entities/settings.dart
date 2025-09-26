import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/settings/chat_events_settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/settings/general_settings.dart';

@immutable
class Settings {
  //CHAT SETTINGS
  final bool isEmotes;
  final double textSize;
  final bool displayTimestamp;
  final ChatEventsSettings chatEventsSettings;
  final ChatSettings chatSettings;

  //GENERAL SETTINGS
  final GeneralSettings generalSettings;

  //CONNECTIONS SETTINGS
  final String rtIrlPushKey;

  const Settings({
    //CHAT SETTINGS
    required this.isEmotes,
    required this.textSize,
    required this.displayTimestamp,
    required this.chatEventsSettings,
    required this.chatSettings,

    //GENERAL SETTINGS
    required this.generalSettings,

    //CONNECTIONS SETTINGS
    required this.rtIrlPushKey,
  });

  Settings copyWith({
    //CHAT
    bool? isEmotes,
    double? textSize,
    bool? displayTimestamp,
    ChatEventsSettings? chatEventsSettings,
    ChatSettings? chatSettings,
    //GENERAL
    GeneralSettings? generalSettings,
    //CONNECTIONS
    String? rtIrlPushKey,
  }) =>
      Settings(
        //CHAT
        isEmotes: isEmotes ?? this.isEmotes,
        textSize: textSize ?? this.textSize,
        displayTimestamp: displayTimestamp ?? this.displayTimestamp,
        chatEventsSettings: chatEventsSettings ?? this.chatEventsSettings,
        chatSettings: chatSettings ?? this.chatSettings,
        //GENERAL
        generalSettings: generalSettings ?? this.generalSettings,
        //CONNECTIONS
        rtIrlPushKey: rtIrlPushKey ?? this.rtIrlPushKey,
      );
}
