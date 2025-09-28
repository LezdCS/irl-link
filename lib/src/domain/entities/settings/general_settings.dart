import 'package:flutter/material.dart';

@immutable
class GeneralSettings {
  final String rtIrlPushKey;
  final bool allowChatEmotes;
  final double textSize;
  final bool displayTimestamp;
  final bool isDarkMode;
  final bool keepSpeakerOn;
  final bool displayViewerCount;
  final Map<dynamic, dynamic> appLanguage;
  final List<double> splitViewWeights;
  final bool rainModeActivated;

  const GeneralSettings({
    required this.rtIrlPushKey,
    required this.allowChatEmotes,
    required this.textSize,
    required this.displayTimestamp,
    required this.isDarkMode,
    required this.keepSpeakerOn,
    required this.displayViewerCount,
    required this.appLanguage,
    required this.splitViewWeights,
    required this.rainModeActivated,
  });

  GeneralSettings copyWith({
    String? rtIrlPushKey,
    bool? allowChatEmotes,
    double? textSize,
    bool? displayTimestamp,
    bool? isDarkMode,
    bool? keepSpeakerOn,
    bool? displayViewerCount,
    Map<dynamic, dynamic>? appLanguage,
    List<double>? splitViewWeights,
    bool? rainModeActivated,
  }) {
    return GeneralSettings(
      rtIrlPushKey: rtIrlPushKey ?? this.rtIrlPushKey,
      allowChatEmotes: allowChatEmotes ?? this.allowChatEmotes,
      textSize: textSize ?? this.textSize,
      displayTimestamp: displayTimestamp ?? this.displayTimestamp,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      keepSpeakerOn: keepSpeakerOn ?? this.keepSpeakerOn,
      displayViewerCount: displayViewerCount ?? this.displayViewerCount,
      appLanguage: appLanguage ?? this.appLanguage,
      splitViewWeights: splitViewWeights ?? this.splitViewWeights,
      rainModeActivated: rainModeActivated ?? this.rainModeActivated,
    );
  }
}
