import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_events_settings.dart';

class ChatEventsSettingsDTO extends ChatEventsSettings {
  const ChatEventsSettingsDTO({
    required super.firstsMessages,
    required super.subscriptions,
    required super.bitsDonations,
    required super.announcements,
    required super.incomingRaids,
    required super.redemptions,
  });

  Map toJson() => {
        'firstsMessages': firstsMessages,
        'subscriptions': subscriptions,
        'bitsDonations': bitsDonations,
        'announcements': announcements,
        'incomingRaids': incomingRaids,
        'redemptions': redemptions,
      };

  factory ChatEventsSettingsDTO.fromJson(Map<String, dynamic> map) {
    return ChatEventsSettingsDTO(
      firstsMessages: map['firstsMessages'] ??
          const Settings.defaultSettings().chatEventsSettings.firstsMessages,
      subscriptions: map['subscriptions'] ??
          const Settings.defaultSettings().chatEventsSettings.subscriptions,
      bitsDonations: map['bitsDonations'] ??
          const Settings.defaultSettings().chatEventsSettings.bitsDonations,
      announcements: map['announcements'] ??
          const Settings.defaultSettings().chatEventsSettings.announcements,
      incomingRaids: map['incomingRaids'] ??
          const Settings.defaultSettings().chatEventsSettings.incomingRaids,
      redemptions: map['redemptions'] ??
          const Settings.defaultSettings().chatEventsSettings.redemptions,
    );
  }
}
