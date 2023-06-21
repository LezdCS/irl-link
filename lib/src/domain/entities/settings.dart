import 'package:equatable/equatable.dart';
import 'package:irllink/src/domain/entities/settings/chat_events_settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/settings/floating_dashboard_settings.dart';
import 'package:irllink/src/domain/entities/settings/stream_elements_settings.dart';

class Settings extends Equatable {
  //CHAT SETTINGS
  final bool? isEmotes;
  final double? textSize;
  final double? emotesSize;
  final bool? displayTimestamp;
  final List? hiddenUsersIds;
  final ChatEventsSettings? chatEventsSettings;
  final ChatSettings? chatSettings;

  //GENERAL SETTINGS
  final bool? isDarkMode;
  final bool? keepSpeakerOn;
  final bool? displayViewerCount;
  final Map? appLanguage;
  final FloatingDashboardSettings? floatingDashboardSettings;

  //CONNECTIONS SETTINGS
  final bool? isObsConnected;
  final String? obsWebsocketUrl;
  final String? obsWebsocketPassword;
  final String? streamElementsAccessToken;
  final List? browserTabs;
  final List? obsConnectionsHistory;
  final StreamElementsSettings? streamElementsSettings;

  //TTS SETTIGS
  final bool? ttsEnabled;
  final String? language;
  final List? prefixsToIgnore;
  final List? prefixsToUseTtsOnly;
  final double? volume;
  final double? pitch;
  final double? rate;
  final Map<String, String>? voice;
  final List? ttsUsersToIgnore;
  final bool? ttsMuteViewerName;

  const Settings({
    //CHAT SETTINGS
    required this.isEmotes,
    required this.textSize,
    required this.emotesSize,
    required this.displayTimestamp,
    required this.hiddenUsersIds,
    required this.chatEventsSettings,
    required this.chatSettings,

    //GENERAL SETTINGS
    required this.isDarkMode,
    required this.keepSpeakerOn,
    required this.appLanguage,
    required this.displayViewerCount,
    required this.floatingDashboardSettings,

    //CONNECTIONS SETTINGS
    required this.isObsConnected,
    required this.obsWebsocketUrl,
    required this.obsWebsocketPassword,
    required this.streamElementsAccessToken,
    required this.browserTabs,
    required this.obsConnectionsHistory,
    required this.streamElementsSettings,

    //TTS SETTIGS
    required this.ttsEnabled,
    required this.language,
    required this.prefixsToIgnore,
    required this.prefixsToUseTtsOnly,
    required this.volume,
    required this.pitch,
    required this.rate,
    required this.voice,
    required this.ttsUsersToIgnore,
    required this.ttsMuteViewerName,
  });

  const Settings.defaultSettings({
    //CHAT SETTINGS
    this.isEmotes = true,
    this.textSize = 19,
    this.emotesSize = 20,
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
    this.isDarkMode = true,
    this.keepSpeakerOn = true,
    this.displayViewerCount = true,
    this.appLanguage = const {"languageCode": "en", "countryCode": "US"},
    this.floatingDashboardSettings = const FloatingDashboardSettings(
      userEvents: [],
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
    this.ttsEnabled = false,
    this.language = "en-US",
    this.prefixsToIgnore = const [],
    this.prefixsToUseTtsOnly = const [],
    this.volume = 1.0,
    this.pitch = 1.0,
    this.rate = 0.5,
    this.voice = const {"name": "en-us-x-sfg-local", "locale": "en-US"},
    this.ttsUsersToIgnore = const [],
    this.ttsMuteViewerName = false,
  });

  Map toJson() => {
        //CHAT
        'isEmotes': isEmotes,
        'textSize': textSize,
        'emotesSize': emotesSize,
        'displayTimestamp': displayTimestamp,
        'hiddenUsersIds': hiddenUsersIds,
        'chatEventsSettings': chatEventsSettings?.toJson(),
        'chatSettings': chatSettings?.toJson(),
        //GENERAL
        'isDarkMode': isDarkMode,
        'keepSpeakerOn': keepSpeakerOn,
        'displayViewerCount': displayViewerCount,
        'appLanguage': appLanguage,
        'floatingDashboardSettings': floatingDashboardSettings?.toJson(),
        //CONNECTIONS
        'isObsConnected': isObsConnected,
        'obsWebsocketUrl': obsWebsocketUrl,
        'obsWebsocketPassword': obsWebsocketPassword,
        'streamElementsAccessToken': streamElementsAccessToken,
        'browserTabs': browserTabs,
        'obsConnectionsHistory': obsConnectionsHistory,
        'streamElementsSettings': streamElementsSettings?.toJson(),
        //TTS
        'ttsEnabled': ttsEnabled,
        'language': language,
        'prefixsToIgnore': prefixsToIgnore,
        'prefixsToUseTtsOnly': prefixsToUseTtsOnly,
        'volume': volume,
        'pitch': pitch,
        'rate': rate,
        'voice': voice,
        'ttsUsersToIgnore': ttsUsersToIgnore,
        'ttsMuteViewerName': ttsMuteViewerName,
      };

  @override
  List<Object?> get props {
    return [
      //CHAT
      isEmotes,
      textSize,
      emotesSize,
      displayTimestamp,
      hiddenUsersIds,
      chatEventsSettings,
      chatSettings,
      //GENERAL
      isDarkMode,
      keepSpeakerOn,
      displayViewerCount,
      appLanguage,
      floatingDashboardSettings,
      //CONNECTIONS
      isObsConnected,
      obsWebsocketUrl,
      obsWebsocketPassword,
      streamElementsAccessToken,
      browserTabs,
      obsConnectionsHistory,
      streamElementsSettings,
      //TTS
      ttsEnabled,
      language,
      prefixsToIgnore,
      prefixsToUseTtsOnly,
      volume,
      pitch,
      rate,
      voice,
      ttsUsersToIgnore,
      ttsMuteViewerName,
    ];
  }

  @override
  bool get stringify => true;

  Settings copyWith({
    //CHAT
    bool? isEmotes,
    double? textSize,
    double? emotesSize,
    bool? displayTimestamp,
    bool? alternateChannel,
    String? alternateChannelName,
    List? hiddenUsersIds,
    ChatEventsSettings? chatEventsSettings,
    ChatSettings? chatSettings,
    //GENERAL
    bool? isDarkMode,
    bool? keepSpeakerOn,
    bool? displayViewerCount,
    Map<String, String>? appLanguage,
    FloatingDashboardSettings? floatingDashboardSettings,
    //CONNECTIONS
    bool? isObsConnected,
    String? obsWebsocketUrl,
    String? obsWebsocketPassword,
    String? streamElementsAccessToken,
    List? browserTabs,
    List? obsConnectionsHistory,
    StreamElementsSettings? streamElementsSettings,
    //TTS
    bool? ttsEnabled,
    String? language,
    List? prefixsToIgnore,
    List? prefixsToUseTtsOnly,
    double? volume,
    double? pitch,
    double? rate,
    Map<String, String>? voice,
    List? ttsUsersToIgnore,
    bool? ttsMuteViewerName,
  }) =>
      Settings(
        //CHAT
        isEmotes: isEmotes ?? this.isEmotes,
        textSize: textSize ?? this.textSize,
        emotesSize: emotesSize ?? this.emotesSize,
        displayTimestamp: displayTimestamp ?? this.displayTimestamp,
        hiddenUsersIds: hiddenUsersIds ?? this.hiddenUsersIds,
        chatEventsSettings: chatEventsSettings ?? this.chatEventsSettings,
        chatSettings: chatSettings ?? this.chatSettings,
        //GENERAL
        isDarkMode: isDarkMode ?? this.isDarkMode,
        keepSpeakerOn: keepSpeakerOn ?? this.keepSpeakerOn,
        displayViewerCount: displayViewerCount ?? this.displayViewerCount,
        appLanguage: appLanguage ?? this.appLanguage,
        floatingDashboardSettings:
            floatingDashboardSettings ?? this.floatingDashboardSettings,
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
        ttsEnabled: ttsEnabled ?? this.ttsEnabled,
        language: language ?? this.language,
        prefixsToIgnore: prefixsToIgnore ?? this.prefixsToIgnore,
        prefixsToUseTtsOnly: prefixsToUseTtsOnly ?? this.prefixsToUseTtsOnly,
        volume: volume ?? this.volume,
        pitch: pitch ?? this.pitch,
        rate: rate ?? this.rate,
        voice: voice ?? this.voice,
        ttsUsersToIgnore: ttsUsersToIgnore ?? this.ttsUsersToIgnore,
        ttsMuteViewerName: ttsMuteViewerName ?? this.ttsMuteViewerName,
      );
}
