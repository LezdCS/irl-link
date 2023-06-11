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

  @override
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
          const Settings.defaultSettings().chatEventsSettings!.firstsMessages,
      subscriptions: map['subscriptions'] ??
          const Settings.defaultSettings().chatEventsSettings!.subscriptions,
      bitsDonations: map['bitsDonations'] ??
          const Settings.defaultSettings().chatEventsSettings!.bitsDonations,
      announcements: map['announcements'] ??
          const Settings.defaultSettings().chatEventsSettings!.announcements,
      incomingRaids: map['incomingRaids'] ??
          const Settings.defaultSettings().chatEventsSettings!.incomingRaids,
      redemptions: map['redemptions'] ??
          const Settings.defaultSettings().chatEventsSettings!.redemptions,
    );
  }
}
