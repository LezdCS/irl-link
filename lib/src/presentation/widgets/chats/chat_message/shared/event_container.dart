import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/chat/chat_emote.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/message_row.dart';

class EventContainer extends StatelessWidget {
  final ChatMessage message;
  final ChatMessage? selectedMessage;
  final bool displayTimestamp;
  final double textSize;
  final bool hideDeletedMessages;
  final List<ChatEmote> cheerEmotes;
  final List<ChatEmote> thirdPartEmotes;
  final bool showPlatformBadge;

  const EventContainer({
    super.key,
    required this.message,
    required this.selectedMessage,
    required this.displayTimestamp,
    required this.textSize,
    required this.hideDeletedMessages,
    required this.cheerEmotes,
    required this.thirdPartEmotes,
    required this.showPlatformBadge,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = getColorFromType(message.eventType!)["border"];
    return Container(
      padding: const EdgeInsets.only(top: 2, bottom: 2, left: 5),
      decoration: BoxDecoration(
        color: selectedMessage != null && selectedMessage == message
            ? Theme.of(Get.context!).colorScheme.secondary
            : getColorFromType(message.eventType!)["background"],
        border: Border(
          left: BorderSide(
            width: 3,
            color: borderColor,
          ),
          right: BorderSide(
            width: 3,
            color: borderColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              getIconFromType(message.eventType!),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  getStringFromType(message.eventType!, message),
                  style: TextStyle(color: Colors.grey[300], fontSize: 16),
                ),
              ),
            ],
          ),
          if (message.message != '') MessageRow(
                  message: message,
                  displayTimestamp: displayTimestamp,
                  textSize: textSize,
                  hideDeletedMessages: hideDeletedMessages,
                  cheerEmotes: cheerEmotes,
                  thirdPartEmotes: thirdPartEmotes,
                  showPlatformBadge: showPlatformBadge,
                ) else Container(),
        ],
      ),
    );
  }

  String getStringFromType(EventType type, ChatMessage message) {
    switch (type) {
      case EventType.bitDonation:
        return "Cheered ${message.totalBits} Bits";
      case EventType.firstTimeChatter:
        return "First message";
      case EventType.channelPointRedemption:
        return "Redeemed a reward";
      case EventType.subscription:
        bool isPrime = message.tier == "Prime";
        return "${message.displayName} subscribed${isPrime ? " with prime" : ""}. They've subscribed for ${message.months} months.";
      case EventType.announcement:
        return "Announcement";
      case EventType.subscriptionGifted:
        return "${message.displayName} gifted a subscription to ${message.giftedName}!";
      case EventType.incomingRaid:
        return "${message.viewerCount} raiders from ${message.raidingChannelName} have joined!";
      default:
        return "Unsupported event";
    }
  }

  Map<String, dynamic> getColorFromType(EventType type) {
    switch (type) {
      case EventType.bitDonation:
        return {
          "border": const Color(0xFF9147ff),
          "background": const Color(0xFF9147ff).withOpacity(0.2),
        };
      case EventType.firstTimeChatter:
        return {
          "border": const Color(0xff0033b5),
          "background": const Color(0xff0033b5).withOpacity(0.2),
        };
      case EventType.channelPointRedemption:
        return {
          "border": const Color(0xff486d1a),
          "background": const Color(0xff486d1a).withOpacity(0.2),
        };
      case EventType.subscription:
        return {
          "border": const Color(0xFF9147ff),
          "background": const Color(0xFF9147ff).withOpacity(0.2),
        };
      case EventType.announcement:
        return {
          "border": const Color(0xffff475c),
          "background": const Color(0xffff475c).withOpacity(0.2),
        };
      case EventType.subscriptionGifted:
        return {
          "border": const Color(0xFF9147ff),
          "background": const Color(0xFF9147ff).withOpacity(0.2),
        };
      case EventType.incomingRaid:
        return {
          "border": const Color(0xffb53600),
          "background": const Color(0xffb53600).withOpacity(0.2),
        };
      default:
        return {
          "border": Colors.black,
          "background": Colors.black.withOpacity(0.2),
        };
    }
  }

  Icon getIconFromType(EventType type) {
    switch (type) {
      case EventType.bitDonation:
        return const Icon(Icons.toll);
      case EventType.firstTimeChatter:
        return const Icon(
          Icons.chat,
          size: 16,
        );
      case EventType.channelPointRedemption:
        return const Icon(Icons.redeem);
      case EventType.subscription:
        return const Icon(Icons.star);
      case EventType.announcement:
        return const Icon(Icons.campaign);
      case EventType.subscriptionGifted:
        return const Icon(Icons.card_giftcard);
      case EventType.incomingRaid:
        return const Icon(Icons.diversity_3);
      default:
        return const Icon(Icons.auto_awesome);
    }
  }
}
