import 'package:irllink/src//domain/entities/settings/tts_settings.dart';
import 'package:irllink/src/domain/entities/settings.dart';

class TtsSettingsDTO extends TtsSettings {
  const TtsSettingsDTO({
    required super.ttsEnabled,
    required super.language,
    required super.prefixsToIgnore,
    required super.prefixsToUseTtsOnly,
    required super.volume,
    required super.pitch,
    required super.rate,
    required super.voice,
    required super.ttsUsersToIgnore,
    required super.ttsMuteViewerName,
    required super.ttsOnlyVip,
    required super.ttsOnlyMod,
    required super.ttsOnlySubscriber,
  });

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
