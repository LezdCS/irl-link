import 'package:equatable/equatable.dart';

class ChatEventsSettings extends Equatable {
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

  @override
  List<Object?> get props {
    return [
      firstsMessages,
      subscriptions,
      bitsDonations,
      announcements,
      incomingRaids,
      redemptions,
    ];
  }

  Map toJson() => {
        'firstsMessages': firstsMessages == true ? 1 : 0,
        'subscriptions': subscriptions == true ? 1 : 0,
        'bitsDonations': bitsDonations == true ? 1 : 0,
        'announcements': announcements == true ? 1 : 0,
        'incomingRaids': incomingRaids == true ? 1 : 0,
        'redemptions': redemptions == true ? 1 : 0,
      };

  @override
  bool get stringify => true;

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
