import 'package:equatable/equatable.dart';

class TtsSettings extends Equatable {
  final bool ttsEnabled;
  final String language;
  final List prefixsToIgnore;
  final List prefixsToUseTtsOnly;
  final double volume;
  final double pitch;
  final double rate;
  final Map<String, String> voice;
  final List ttsUsersToIgnore;
  final bool ttsMuteViewerName;

  const TtsSettings({
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

  @override
  List<Object?> get props {
    return [
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

  @override
  bool get stringify => true;

  TtsSettings copyWith({
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
  }) {
    return TtsSettings(
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
}
