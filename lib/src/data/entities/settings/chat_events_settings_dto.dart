import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_events_settings.dart';

class ChatEventsSettingsDTO extends ChatEventsSettings {
  const ChatEventsSettingsDTO({
    required bool firstsMessages,
    required bool subscriptions,
    required bool bitsDonations,
    required bool announcements,
    required bool incomingRaids,
    required bool redemptions,
  }) : super(
          firstsMessages: firstsMessages,
          subscriptions: subscriptions,
          bitsDonations: bitsDonations,
          announcements: announcements,
          incomingRaids: incomingRaids,
          redemptions: redemptions,
        );

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
          Settings.defaultSettings().chatEventsSettings!.firstsMessages,
      subscriptions: map['subscriptions'] ??
          Settings.defaultSettings().chatEventsSettings!.subscriptions,
      bitsDonations: map['bitsDonations'] ??
          Settings.defaultSettings().chatEventsSettings!.bitsDonations,
      announcements: map['announcements'] ??
          Settings.defaultSettings().chatEventsSettings!.announcements,
      incomingRaids: map['incomingRaids'] ??
          Settings.defaultSettings().chatEventsSettings!.incomingRaids,
      redemptions: map['redemptions'] ??
          Settings.defaultSettings().chatEventsSettings!.redemptions,
    );
  }
}
