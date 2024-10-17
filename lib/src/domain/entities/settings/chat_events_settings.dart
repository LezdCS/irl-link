

class ChatEventsSettings {
  final bool firstsMessages;
  final bool subscriptions;
  final bool bitsDonations;
  final bool announcements;
  final bool incomingRaids;
  final bool redemptions;

  const ChatEventsSettings({
    required this.firstsMessages,
    required this.subscriptions,
    required this.bitsDonations,
    required this.announcements,
    required this.incomingRaids,
    required this.redemptions,
  });

  Map toJson() => {
        'firstsMessages': firstsMessages,
        'subscriptions': subscriptions,
        'bitsDonations': bitsDonations,
        'announcements': announcements,
        'incomingRaids': incomingRaids,
        'redemptions': redemptions,
      };

  

  ChatEventsSettings copyWith({
    bool? firstsMessages,
    bool? subscriptions,
    bool? bitsDonations,
    bool? announcements,
    bool? incomingRaids,
    bool? redemptions,
  }) {
    return ChatEventsSettings(
      firstsMessages: firstsMessages ?? this.firstsMessages,
      subscriptions: subscriptions ?? this.subscriptions,
      bitsDonations: bitsDonations ?? this.bitsDonations,
      announcements: announcements ?? this.announcements,
      incomingRaids: incomingRaids ?? this.incomingRaids,
      redemptions: redemptions ?? this.redemptions,
    );
  }
}
