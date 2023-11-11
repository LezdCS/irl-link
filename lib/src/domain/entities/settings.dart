import 'package:equatable/equatable.dart';
import 'package:irllink/src/domain/entities/settings/chat_events_settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/settings/dashboard_settings.dart';
import 'package:irllink/src/domain/entities/settings/general_settings.dart';
import 'package:irllink/src/domain/entities/settings/stream_elements_settings.dart';
import 'package:irllink/src/domain/entities/settings/tts_settings.dart';

class Settings extends Equatable {
  //CHAT SETTINGS
  final bool? isEmotes;
  final double? textSize;
  final bool? displayTimestamp;
  final List? hiddenUsersIds;
  final ChatEventsSettings? chatEventsSettings;
  final ChatSettings? chatSettings;

  //GENERAL SETTINGS
  final GeneralSettings? generalSettings;
  final DashboardSettings? dashboardSettings;

  //CONNECTIONS SETTINGS
  final bool? isObsConnected;
  final String? obsWebsocketUrl;
  final String? obsWebsocketPassword;
  final String? streamElementsAccessToken;
  final List? browserTabs;
  final List? obsConnectionsHistory;
  final StreamElementsSettings? streamElementsSettings;

  //TTS SETTIGS
  final TtsSettings? ttsSettings;

  const Settings({
    //CHAT SETTINGS
    required this.isEmotes,
    required this.textSize,
    required this.displayTimestamp,
    required this.hiddenUsersIds,
    required this.chatEventsSettings,
    required this.chatSettings,

    //GENERAL SETTINGS
    required this.generalSettings,
    required this.dashboardSettings,

    //CONNECTIONS SETTINGS
    required this.isObsConnected,
    required this.obsWebsocketUrl,
    required this.obsWebsocketPassword,
    required this.streamElementsAccessToken,
    required this.browserTabs,
    required this.obsConnectionsHistory,
    required this.streamElementsSettings,

    //TTS SETTIGS
    required this.ttsSettings,
  });

  const Settings.defaultSettings({
    //CHAT SETTINGS
    this.isEmotes = true,
    this.textSize = 19,
    this.displayTimestamp = false,
    this.hiddenUsersIds = const [],
    this.chatEventsSettings = const ChatEventsSettings(
      firstsMessages: true,
      subscriptions: true,
      bitsDonations: true,
      announcements: true,
      incomingRaids: true,
      redemptions: true,
    ),
    this.chatSettings = const ChatSettings(
      chatsJoined: [],
      joinMyself: true,
      hideDeletedMessages: true,
    ),

    //GENERAL SETTINGS
    this.generalSettings = const GeneralSettings(
      isDarkMode: true,
      keepSpeakerOn: true,
      displayViewerCount: true,
      appLanguage: {"languageCode": "en", "countryCode": "US"},
      splitViewWeights: [0.5, 0.5],
    ),
    this.dashboardSettings = const DashboardSettings(
      userEvents: [],
      activated: true,
    ),

    //CONNECTIONS SETTINGS
    this.isObsConnected = false,
    this.obsWebsocketUrl = "",
    this.obsWebsocketPassword = "",
    this.streamElementsAccessToken = "",
    this.browserTabs = const [],
    this.obsConnectionsHistory = const [],
    this.streamElementsSettings = const StreamElementsSettings(
      showFollowerActivity: true,
      showSubscriberActivity: true,
      showDonationActivity: true,
      showCheerActivity: true,
      showRaidActivity: true,
      showHostActivity: true,
      showMerchActivity: true,
    ),

    //TTS SETTINGS
    this.ttsSettings = const TtsSettings(
      ttsEnabled: false,
      language: "en-US",
      prefixsToIgnore: [],
      prefixsToUseTtsOnly: [],
      volume: 1.0,
      pitch: 1.0,
      rate: 0.5,
      voice: {"name": "en-us-x-sfg-local", "locale": "en-US"},
      ttsUsersToIgnore: [],
      ttsMuteViewerName: false,
    ),
  });

  Map toJson() => {
        //CHAT
        'isEmotes': isEmotes,
        'textSize': textSize,
        'displayTimestamp': displayTimestamp,
        'hiddenUsersIds': hiddenUsersIds,
        'chatEventsSettings': chatEventsSettings?.toJson(),
        'chatSettings': chatSettings?.toJson(),
        //GENERAL
        'generalSettings': generalSettings?.toJson(),
        'dashboardSettings': dashboardSettings?.toJson(),
        //CONNECTIONS
        'isObsConnected': isObsConnected,
        'obsWebsocketUrl': obsWebsocketUrl,
        'obsWebsocketPassword': obsWebsocketPassword,
        'streamElementsAccessToken': streamElementsAccessToken,
        'browserTabs': browserTabs,
        'obsConnectionsHistory': obsConnectionsHistory,
        'streamElementsSettings': streamElementsSettings?.toJson(),
        //TTS
        'ttsSettings': ttsSettings?.toJson(),
      };

  @override
  List<Object?> get props {
    return [
      //CHAT
      isEmotes,
      textSize,
      displayTimestamp,
      hiddenUsersIds,
      chatEventsSettings,
      chatSettings,
      //GENERAL
      generalSettings,
      dashboardSettings,
      //CONNECTIONS
      isObsConnected,
      obsWebsocketUrl,
      obsWebsocketPassword,
      streamElementsAccessToken,
      browserTabs,
      obsConnectionsHistory,
      streamElementsSettings,
      //TTS
      ttsSettings
    ];
  }

  @override
  bool get stringify => true;

  Settings copyWith(
          {
          //CHAT
          bool? isEmotes,
          double? textSize,
          bool? displayTimestamp,
          bool? alternateChannel,
          String? alternateChannelName,
          List? hiddenUsersIds,
          ChatEventsSettings? chatEventsSettings,
          ChatSettings? chatSettings,
          //GENERAL
          GeneralSettings? generalSettings,
          DashboardSettings? dashboardSettings,
          //CONNECTIONS
          bool? isObsConnected,
          String? obsWebsocketUrl,
          String? obsWebsocketPassword,
          String? streamElementsAccessToken,
          List? browserTabs,
          List? obsConnectionsHistory,
          StreamElementsSettings? streamElementsSettings,
          //TTS
          TtsSettings? ttsSettings}) =>
      Settings(
        //CHAT
        isEmotes: isEmotes ?? this.isEmotes,
        textSize: textSize ?? this.textSize,
        displayTimestamp: displayTimestamp ?? this.displayTimestamp,
        hiddenUsersIds: hiddenUsersIds ?? this.hiddenUsersIds,
        chatEventsSettings: chatEventsSettings ?? this.chatEventsSettings,
        chatSettings: chatSettings ?? this.chatSettings,
        //GENERAL
        generalSettings: generalSettings ?? this.generalSettings,
        dashboardSettings:
            dashboardSettings ?? this.dashboardSettings,
        //CONNECTIONS
        isObsConnected: isObsConnected ?? this.isObsConnected,
        obsWebsocketUrl: obsWebsocketUrl ?? this.obsWebsocketUrl,
        obsWebsocketPassword: obsWebsocketPassword ?? this.obsWebsocketPassword,
        streamElementsAccessToken:
            streamElementsAccessToken ?? this.streamElementsAccessToken,
        browserTabs: browserTabs ?? this.browserTabs,
        obsConnectionsHistory:
            obsConnectionsHistory ?? this.obsConnectionsHistory,
        streamElementsSettings:
            streamElementsSettings ?? this.streamElementsSettings,
        //TTS
        ttsSettings: ttsSettings ?? this.ttsSettings,
      );
}
