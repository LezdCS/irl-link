import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/chat/twitch_chat_message.dart';

import '../../../domain/entities/chat/sub_gift_event.dart';
import '../../../domain/entities/chat/subscription_event.dart';
import '../../controllers/chat_view_controller.dart';

class EventContainer extends StatelessWidget {
  final ChatViewController controller;
  final TwitchChatMessage message;
  final Widget child;

  const EventContainer({
    required this.controller,
    required this.message,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = getColorFromType(message.highlightType!)["border"];
    return Container(
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 5),
      decoration: BoxDecoration(
        color: controller.selectedMessage.value == message
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
          Container(
            child: Text(
              getStringFromType(message.highlightType!, message),
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),
          message.messageWidgetsBuild.length > 0 ? child : Container(),
        ],
      ),
    );
  }

  String getStringFromType(HighlightType type, TwitchChatMessage message) {
    switch (type) {
      case HighlightType.bitDonation:
        return "Cheered ${message.bitAmount.toString()} Bits";
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
        return "${message.authorName} gifted a subscription to ${msg.giftedName}";
      default:
        return "";
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
          "border": Color(0xffb500a6),
          "background": Color(0xffb500a6).withOpacity(0.2)
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
      default:
        return {
          "border": Colors.white,
          "background": Colors.white.withOpacity(0.2)
        };
    }
  }
}
