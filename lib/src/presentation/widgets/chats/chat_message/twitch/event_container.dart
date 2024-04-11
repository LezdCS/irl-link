import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitch_chat/twitch_chat.dart';

import 'message_row.dart';

class EventContainer extends StatelessWidget {
  final ChatMessage message;
  final ChatMessage? selectedMessage;
  final bool displayTimestamp;
  final double textSize;
  final TwitchChat? twitchChat;
  final bool hideDeletedMessages;

  const EventContainer({
    super.key,
    required this.message,
    required this.selectedMessage,
    required this.displayTimestamp,
    required this.textSize,
    this.twitchChat,
    required this.hideDeletedMessages,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = getColorFromType(message.highlightType!)["border"];
    return Container(
      padding: const EdgeInsets.only(top: 2, bottom: 2, left: 5),
      decoration: BoxDecoration(
        color: selectedMessage != null && selectedMessage == message
            ? Theme.of(Get.context!).colorScheme.secondary
            : getColorFromType(message.highlightType!)["background"],
        border: Border(
          left: BorderSide(
            width: 3.0,
            color: borderColor,
          ),
          right: BorderSide(
            width: 3.0,
            color: borderColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              getIconFromType(message.highlightType!),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  getStringFromType(message.highlightType!, message),
                  style: TextStyle(color: Colors.grey[300], fontSize: 16),
                ),
              ),
            ],
          ),
          message.message != ''
              ? MessageRow(
                  message: message,
                  displayTimestamp: displayTimestamp,
                  textSize: textSize,
                  twitchChat: twitchChat,
                  hideDeletedMessages: hideDeletedMessages,
                )
              : Container(),
        ],
      ),
    );
  }

  String getStringFromType(HighlightType type, ChatMessage message) {
    switch (type) {
      case HighlightType.bitDonation:
        BitDonation msg = message as BitDonation;
        return "Cheered ${msg.totalBits.toString()} Bits";
      case HighlightType.firstTimeChatter:
        return "First message";
      case HighlightType.channelPointRedemption:
        return "Redeemed a reward";
      case HighlightType.subscription:
        Subscription msg = message as Subscription;
        bool isPrime = msg.tier == "Prime";
        return "${message.displayName} subscribed${isPrime ? " with prime" : ""}. They've subscribed for ${msg.months} months.";
      case HighlightType.announcement:
        return "Announcement";
      case HighlightType.subscriptionGifted:
        SubGift msg = message as SubGift;
        return "${message.displayName} gifted a subscription to ${msg.giftedName}!";
      case HighlightType.incomingRaid:
        IncomingRaid raid = message as IncomingRaid;
        return "${raid.viewerCount} raiders from ${raid.raidingChannelName} have joined!";
      default:
        return "Unsupported event";
    }
  }

  Map<String, dynamic> getColorFromType(HighlightType type) {
    switch (type) {
      case HighlightType.bitDonation:
        return {
          "border": const Color(0xFF9147ff),
          "background": const Color(0xFF9147ff).withOpacity(0.2)
        };
      case HighlightType.firstTimeChatter:
        return {
          "border": const Color(0xff0033b5),
          "background": const Color(0xff0033b5).withOpacity(0.2)
        };
      case HighlightType.channelPointRedemption:
        return {
          "border": const Color(0xff486d1a),
          "background": const Color(0xff486d1a).withOpacity(0.2)
        };
      case HighlightType.subscription:
        return {
          "border": const Color(0xFF9147ff),
          "background": const Color(0xFF9147ff).withOpacity(0.2)
        };
      case HighlightType.announcement:
        return {
          "border": const Color(0xffff475c),
          "background": const Color(0xffff475c).withOpacity(0.2)
        };
      case HighlightType.subscriptionGifted:
        return {
          "border": const Color(0xFF9147ff),
          "background": const Color(0xFF9147ff).withOpacity(0.2)
        };
      case HighlightType.incomingRaid:
        return {
          "border": const Color(0xffb53600),
          "background": const Color(0xffb53600).withOpacity(0.2)
        };
      default:
        return {
          "border": Colors.black,
          "background": Colors.black.withOpacity(0.2)
        };
    }
  }

  Icon getIconFromType(HighlightType type) {
    switch (type) {
      case HighlightType.bitDonation:
        return const Icon(Icons.toll);
      case HighlightType.firstTimeChatter:
        return const Icon(
          Icons.chat,
          size: 16,
        );
      case HighlightType.channelPointRedemption:
        return const Icon(Icons.redeem);
      case HighlightType.subscription:
        return const Icon(Icons.star);
      case HighlightType.announcement:
        return const Icon(Icons.campaign);
      case HighlightType.subscriptionGifted:
        return const Icon(Icons.card_giftcard);
      case HighlightType.incomingRaid:
        return const Icon(Icons.diversity_3);
      default:
        return const Icon(Icons.auto_awesome);
    }
  }
}
