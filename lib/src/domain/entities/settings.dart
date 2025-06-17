import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_events_settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/settings/dashboard_settings.dart';
import 'package:irllink/src/domain/entities/settings/general_settings.dart';
import 'package:irllink/src/domain/entities/settings/stream_elements_settings.dart';
import 'package:irllink/src/domain/entities/settings/tts_settings.dart';

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
  final DashboardSettings dashboardSettings;

  //CONNECTIONS SETTINGS
  final bool isObsConnected;
  final String obsWebsocketUrl;
  final String obsWebsocketPassword;
  final BrowserTabSettings browserTabs;
  final List obsConnectionsHistory;
  final StreamElementsSettings streamElementsSettings;
  final String rtIrlPushKey;

  //TTS SETTIGS
  final TtsSettings ttsSettings;

  const Settings({
    //CHAT SETTINGS
    required this.isEmotes,
    required this.textSize,
    required this.displayTimestamp,
    required this.chatEventsSettings,
    required this.chatSettings,

    //GENERAL SETTINGS
    required this.generalSettings,
    required this.dashboardSettings,

    //CONNECTIONS SETTINGS
    required this.isObsConnected,
    required this.obsWebsocketUrl,
    required this.obsWebsocketPassword,
    required this.browserTabs,
    required this.obsConnectionsHistory,
    required this.streamElementsSettings,
    required this.rtIrlPushKey,

    //TTS SETTIGS
    required this.ttsSettings,
  });

  Settings copyWith({
    //CHAT
    bool? isEmotes,
    double? textSize,
    bool? displayTimestamp,
    bool? alternateChannel,
    String? alternateChannelName,
    ChatEventsSettings? chatEventsSettings,
    ChatSettings? chatSettings,
    //GENERAL
    GeneralSettings? generalSettings,
    DashboardSettings? dashboardSettings,
    //CONNECTIONS
    bool? isObsConnected,
    String? obsWebsocketUrl,
    String? obsWebsocketPassword,
    BrowserTabSettings? browserTabs,
    List? obsConnectionsHistory,
    StreamElementsSettings? streamElementsSettings,
    String? rtIrlPushKey,
    //TTS
    TtsSettings? ttsSettings,
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
        dashboardSettings: dashboardSettings ?? this.dashboardSettings,
        //CONNECTIONS
        isObsConnected: isObsConnected ?? this.isObsConnected,
        obsWebsocketUrl: obsWebsocketUrl ?? this.obsWebsocketUrl,
        obsWebsocketPassword: obsWebsocketPassword ?? this.obsWebsocketPassword,
        browserTabs: browserTabs ?? this.browserTabs,
        obsConnectionsHistory:
            obsConnectionsHistory ?? this.obsConnectionsHistory,
        streamElementsSettings:
            streamElementsSettings ?? this.streamElementsSettings,
        rtIrlPushKey: rtIrlPushKey ?? this.rtIrlPushKey,
        //TTS
        ttsSettings: ttsSettings ?? this.ttsSettings,
      );
}
