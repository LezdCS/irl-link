import 'package:irllink/src/domain/entities/settings.dart';

import '../../../domain/entities/settings/tts_settings.dart';

class TtsSettingsDTO extends TtsSettings {
  const TtsSettingsDTO({
    required bool ttsEnabled,
    required String language,
    required List prefixsToIgnore,
    required List prefixsToUseTtsOnly,
    required double volume,
    required double pitch,
    required double rate,
    required Map<String, String> voice,
    required List ttsUsersToIgnore,
    required bool ttsMuteViewerName,
    required bool ttsOnlyVip,
    required bool ttsOnlyMod,
    required bool ttsOnlySubscriber,
  }) : super(
          ttsEnabled: ttsEnabled,
          language: language,
          prefixsToIgnore: prefixsToIgnore,
          prefixsToUseTtsOnly: prefixsToUseTtsOnly,
          volume: volume,
          pitch: pitch,
          rate: rate,
          voice: voice,
          ttsUsersToIgnore: ttsUsersToIgnore,
          ttsMuteViewerName: ttsMuteViewerName,
          ttsOnlyVip: ttsOnlyVip,
          ttsOnlyMod: ttsOnlyMod,
          ttsOnlySubscriber: ttsOnlySubscriber,
        );

  @override
  Map toJson() => {
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

  factory TtsSettingsDTO.fromJson(Map<String, dynamic> map) {
    return TtsSettingsDTO(
      ttsEnabled: map['ttsEnabled'] ??
          const Settings.defaultSettings().ttsSettings!.ttsEnabled,
      language: map['language'] ??
          const Settings.defaultSettings().ttsSettings!.language,
      prefixsToIgnore: map['prefixsToIgnore'] ??
          const Settings.defaultSettings().ttsSettings!.prefixsToIgnore,
      prefixsToUseTtsOnly: map['prefixsToUseTtsOnly'] ??
          const Settings.defaultSettings().ttsSettings!.prefixsToUseTtsOnly,
      volume:
          map['volume'] ?? const Settings.defaultSettings().ttsSettings!.volume,
      pitch:
          map['pitch'] ?? const Settings.defaultSettings().ttsSettings!.pitch,
      rate: map['rate'] ?? const Settings.defaultSettings().ttsSettings!.rate,
      voice: map['voice'] != null
          ? {"name": map["voice"]["name"], "locale": map["voice"]["locale"]}
          : const Settings.defaultSettings().ttsSettings!.voice,
      ttsUsersToIgnore: map['ttsUsersToIgnore'] ??
          const Settings.defaultSettings().ttsSettings!.ttsUsersToIgnore,
      ttsMuteViewerName: map['ttsMuteViewerName'] ??
          const Settings.defaultSettings().ttsSettings!.ttsMuteViewerName,
      ttsOnlyVip: map['ttsOnlyVip'] ??
          const Settings.defaultSettings().ttsSettings!.ttsOnlyVip,
      ttsOnlyMod: map['ttsOnlyMod'] ??
          const Settings.defaultSettings().ttsSettings!.ttsOnlyMod,
      ttsOnlySubscriber: map['ttsOnlySubscriber'] ??
          const Settings.defaultSettings().ttsSettings!.ttsOnlySubscriber,
    );
  }
}
