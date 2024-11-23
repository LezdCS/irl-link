import 'package:flutter/material.dart';

@immutable
class GeneralSettings {
  final bool isDarkMode;
  final bool keepSpeakerOn;
  final bool displayViewerCount;
  final Map<dynamic, dynamic> appLanguage;
  final List<double> splitViewWeights;

  const GeneralSettings({
    required this.isDarkMode,
    required this.keepSpeakerOn,
    required this.displayViewerCount,
    required this.appLanguage,
    required this.splitViewWeights,
  });

  GeneralSettings copyWith({
    bool? isDarkMode,
    bool? keepSpeakerOn,
    bool? displayViewerCount,
    Map<dynamic, dynamic>? appLanguage,
    List<double>? splitViewWeights,
  }) {
    return GeneralSettings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      keepSpeakerOn: keepSpeakerOn ?? this.keepSpeakerOn,
      displayViewerCount: displayViewerCount ?? this.displayViewerCount,
      appLanguage: appLanguage ?? this.appLanguage,
      splitViewWeights: splitViewWeights ?? this.splitViewWeights,
    );
  }
}
