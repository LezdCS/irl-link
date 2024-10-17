

class TtsSettings {
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
  final bool ttsOnlyVip;
  final bool ttsOnlyMod;
  final bool ttsOnlySubscriber;

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
    required this.ttsOnlyVip,
    required this.ttsOnlyMod,
    required this.ttsOnlySubscriber,
  });

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
        'ttsOnlyVip': ttsOnlyVip,
        'ttsOnlyMod': ttsOnlyMod,
        'ttsOnlySubscriber': ttsOnlySubscriber,
      };

  

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
    bool? ttsOnlyVip,
    bool? ttsOnlyMod,
    bool? ttsOnlySubscriber,
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
      ttsOnlyVip: ttsOnlyVip ?? this.ttsOnlyVip,
      ttsOnlyMod: ttsOnlyMod ?? this.ttsOnlyMod,
      ttsOnlySubscriber: ttsOnlySubscriber ?? this.ttsOnlySubscriber,
    );
  }
}
