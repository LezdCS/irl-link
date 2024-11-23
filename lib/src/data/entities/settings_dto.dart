import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irllink/src/data/entities/settings/browser_tab_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/chat_events_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/chat_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/dashboard_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/general_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/stream_elements_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/tts_settings_dto.dart';

part 'settings_dto.freezed.dart';
part 'settings_dto.g.dart';

@freezed
class SettingsDTO with _$SettingsDTO {
  const factory SettingsDTO({
    //CHAT SETTINGS
    @Default(true) bool isEmotes,
    @Default(19) double textSize,
    @Default(false) bool displayTimestamp,
    @Default([]) List hiddenUsersIds,
    required ChatEventsSettingsDTO chatEventsSettings,
    required ChatSettingsDTO chatSettings,
    //GENERAL SETTINGS
    required GeneralSettingsDTO generalSettings,
    required DashboardSettingsDTO dashboardSettings,
    //CONNECTIONS SETTINGS
    @Default(false) bool isObsConnected,
    @Default("") String obsWebsocketUrl,
    @Default("") String obsWebsocketPassword,
    required BrowserTabSettingsDTO browserTabs,
    @Default([]) List obsConnectionsHistory,
    required StreamElementsSettingsDTO streamElementsSettings,
    @Default("") String rtIrlPushKey,
    //TTS SETTINGS
    required TtsSettingsDTO ttsSettings,
  }) = _SettingsDTO;

  factory SettingsDTO.blank() => SettingsDTO(
        browserTabs: BrowserTabSettingsDTO.blank(),
        chatEventsSettings: ChatEventsSettingsDTO.blank(),
        chatSettings: ChatSettingsDTO.blank(),
        dashboardSettings: DashboardSettingsDTO.blank(),
        generalSettings: GeneralSettingsDTO.blank(),
        streamElementsSettings: StreamElementsSettingsDTO.blank(),
        ttsSettings: TtsSettingsDTO.blank(),
      );
  factory SettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$SettingsDTOFromJson(json);
}
