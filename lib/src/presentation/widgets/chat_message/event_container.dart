import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/chat/incoming_raid_event.dart';
import 'package:irllink/src/domain/entities/chat/twitch_chat_message.dart';

import '../../../domain/entities/chat/bit_donation_event.dart';
import '../../../domain/entities/chat/sub_gift_event.dart';
import '../../../domain/entities/chat/subscription_event.dart';
import 'message_row.dart';

class EventContainer extends StatelessWidget {
  final TwitchChatMessage message;
  final TwitchChatMessage? selectedMessage;
  final bool displayTimestamp;
  final double textSize;

  const EventContainer({
    required this.message,
    required this.selectedMessage,
    required this.displayTimestamp,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = getColorFromType(message.highlightType!)["border"];
    return Container(
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 5),
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
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  getStringFromType(message.highlightType!, message),
                  style: TextStyle(color: Colors.grey[300], fontSize: 16),
                ),
              ),
            ],
          ),
          message.messageWidgetsBuild.length > 0
              ? MessageRow(
                  message: message,
                  displayTimestamp: displayTimestamp,
                  textSize: textSize,
                )
              : Container(),
        ],
      ),
    );
  }

  String getStringFromType(HighlightType type, TwitchChatMessage message) {
    switch (type) {
      case HighlightType.bitDonation:
        BitDonationEvent msg = message as BitDonationEvent;
        return "Cheered ${msg.totalBits.toString()} Bits";
      case HighlightType.firstTimeChatter:
        return "First message";
      case HighlightType.channelPointRedemption:
        return "Redeemed a reward";
      case HighlightType.subscription:
        SubscriptionEvent msg = message as SubscriptionEvent;
        bool isPrime = msg.tier == "Prime";
        return "${message.authorName} subscribed${isPrime ? " with prime" : ""}. They've subscribed for ${msg.months} months.";
      case HighlightType.announcement:
        return "Announcement";
      case HighlightType.subscriptionGifted:
        SubGiftEvent msg = message as SubGiftEvent;
        return "${message.authorName} gifted a subscription to ${msg.giftedName}!";
      case HighlightType.incomingRaid:
        IncomingRaidEvent raid = message as IncomingRaidEvent;
        return "${raid.viewerCount} raiders from ${raid.raidingChannelName} have joined!";
      default:
        return "Unsupported event";
    }
  }

  Map<String, dynamic> getColorFromType(HighlightType type) {
    switch (type) {
      case HighlightType.bitDonation:
        return {
          "border": Color(0xFF9147ff),
          "background": Color(0xFF9147ff).withOpacity(0.2)
        };
      case HighlightType.firstTimeChatter:
        return {
          "border": Color(0xff0033b5),
          "background": Color(0xff0033b5).withOpacity(0.2)
        };
      case HighlightType.channelPointRedemption:
        return {
          "border": Color(0xff486d1a),
          "background": Color(0xff486d1a).withOpacity(0.2)
        };
      case HighlightType.subscription:
        return {
          "border": Color(0xFF9147ff),
          "background": Color(0xFF9147ff).withOpacity(0.2)
        };
      case HighlightType.announcement:
        return {
          "border": Color(0xffff475c),
          "background": Color(0xffff475c).withOpacity(0.2)
        };
      case HighlightType.subscriptionGifted:
        return {
          "border": Color(0xFF9147ff),
          "background": Color(0xFF9147ff).withOpacity(0.2)
        };
      case HighlightType.incomingRaid:
        return {
          "border": Color(0xffb53600),
          "background": Color(0xffb53600).withOpacity(0.2)
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
        return Icon(Icons.toll);
      case HighlightType.firstTimeChatter:
        return Icon(
          Icons.chat,
          size: 16,
        );
      case HighlightType.channelPointRedemption:
        return Icon(Icons.redeem);
      case HighlightType.subscription:
        return Icon(Icons.star);
      case HighlightType.announcement:
        return Icon(Icons.campaign);
      case HighlightType.subscriptionGifted:
        return Icon(Icons.card_giftcard);
      case HighlightType.incomingRaid:
        return Icon(Icons.diversity_3);
      default:
        return Icon(Icons.auto_awesome);
    }
  }
}
