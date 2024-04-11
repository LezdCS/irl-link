import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/stream_elements_settings.dart';

class StreamElementsSettingsDTO extends StreamElementsSettings {
  const StreamElementsSettingsDTO({
    required super.showFollowerActivity,
    required super.showSubscriberActivity,
    required super.showDonationActivity,
    required super.showCheerActivity,
    required super.showRaidActivity,
    required super.showHostActivity,
    required super.showMerchActivity,
  });

  @override
  Map toJson() => {
        'showFollowerActivity': showFollowerActivity,
        'showSubscriberActivity': showSubscriberActivity,
        'showDonationActivity': showDonationActivity,
        'showCheerActivity': showCheerActivity,
        'showRaidActivity': showRaidActivity,
        'showHostActivity': showHostActivity,
        'showMerchActivity': showMerchActivity,
      };

  factory StreamElementsSettingsDTO.fromJson(Map<String, dynamic> map) {
    return StreamElementsSettingsDTO(
      showFollowerActivity: map['showFollowerActivity'] ??
          const Settings.defaultSettings()
              .streamElementsSettings!
              .showFollowerActivity,
      showSubscriberActivity: map['showSubscriberActivity'] ??
          const Settings.defaultSettings()
              .streamElementsSettings!
              .showSubscriberActivity,
      showDonationActivity: map['showDonationActivity'] ??
          const Settings.defaultSettings()
              .streamElementsSettings!
              .showDonationActivity,
      showCheerActivity: map['showCheerActivity'] ??
          const Settings.defaultSettings()
              .streamElementsSettings!
              .showCheerActivity,
      showRaidActivity: map['showRaidActivity'] ??
          const Settings.defaultSettings()
              .streamElementsSettings!
              .showRaidActivity,
      showHostActivity: map['showHostActivity'] ??
          const Settings.defaultSettings()
              .streamElementsSettings!
              .showHostActivity,
      showMerchActivity: map['showMerchActivity'] ??
          const Settings.defaultSettings()
              .streamElementsSettings!
              .showMerchActivity,
    );
  }
}
