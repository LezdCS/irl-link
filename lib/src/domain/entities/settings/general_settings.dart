import 'package:equatable/equatable.dart';

class GeneralSettings extends Equatable {
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

  @override
  List<Object?> get props {
    return [
      isDarkMode,
      keepSpeakerOn,
      displayViewerCount,
      appLanguage,
      splitViewWeights,
    ];
  }

  Map toJson() => {
    'isDarkMode': isDarkMode,
    'keepSpeakerOn': keepSpeakerOn,
    'displayViewerCount': displayViewerCount,
    'appLanguage': appLanguage,
    'splitViewWeights': splitViewWeights,
  };

  @override
  bool get stringify => true;

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
