import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/general_settings.dart';

class GeneralSettingsDTO extends GeneralSettings {
  const GeneralSettingsDTO({
    required bool isDarkMode,
    required bool keepSpeakerOn,
    required bool displayViewerCount,
    required Map<dynamic, dynamic> appLanguage,
    required List<double> splitViewWeights,
  }) : super(
          isDarkMode: isDarkMode,
          keepSpeakerOn: keepSpeakerOn,
          displayViewerCount: displayViewerCount,
          appLanguage: appLanguage,
          splitViewWeights: splitViewWeights,
        );

  @override
  Map toJson() => {
        'isDarkMode': isDarkMode,
        'keepSpeakerOn': keepSpeakerOn,
        'displayViewerCount': displayViewerCount,
        'appLanguage': appLanguage,
        'splitViewWeights': splitViewWeights,
      };

  factory GeneralSettingsDTO.fromJson(Map<String, dynamic> map) {
    return GeneralSettingsDTO(
      isDarkMode: map['isDarkMode'] ??
          const Settings.defaultSettings().generalSettings!.isDarkMode,
      keepSpeakerOn: map['keepSpeakerOn'] ??
          const Settings.defaultSettings().generalSettings!.keepSpeakerOn,
      displayViewerCount: map['displayViewerCount'] ??
          const Settings.defaultSettings().generalSettings!.displayViewerCount,
      appLanguage: map['appLanguage'] ??
          const Settings.defaultSettings().generalSettings!.appLanguage,
      splitViewWeights: (map['splitViewWeights'] as List?)
              ?.map((item) => item as double)
              .toList() ??
          const Settings.defaultSettings().generalSettings!.splitViewWeights,
    );
  }
}
