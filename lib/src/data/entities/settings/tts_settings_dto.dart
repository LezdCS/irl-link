import 'package:freezed_annotation/freezed_annotation.dart';

part 'tts_settings_dto.freezed.dart';
part 'tts_settings_dto.g.dart';

@freezed
class TtsSettingsDTO with _$TtsSettingsDTO {
  const factory TtsSettingsDTO({
    @Default(false) bool ttsEnabled,
    @Default("en-US") String language,
    @Default([]) List prefixsToIgnore,
    @Default([]) List prefixsToUseTtsOnly,
    @Default(1) double volume,
    @Default(1) double pitch,
    @Default(0.5) double rate,
    @Default({"name": "en-us-x-sfg-local", "locale": "en-US"}) Map<String, String> voice,
    @Default([]) List ttsUsersToIgnore,
    @Default(false) bool ttsMuteViewerName,
    @Default(false) bool ttsOnlyVip,
    @Default(false) bool ttsOnlyMod,
    @Default(false) bool ttsOnlySubscriber,
  }) = _TtsSettingsDTO;

  factory TtsSettingsDTO.fromJson(Map<String, dynamic> json) => _$TtsSettingsDTOFromJson(json);
}
