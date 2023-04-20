import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/twitch_chat_message.dart';

import '../../controllers/chat_view_controller.dart';

class HighlightMessageRow extends StatelessWidget {
  final ChatViewController controller;
  final TwitchChatMessage message;
  final Widget child;

  const HighlightMessageRow({
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
          child,
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
          "border": Color(0xFF00b5ad),
          "background": Color(0xFF00b5ad).withOpacity(0.2)
        };
      case HighlightType.channelPointRedemption:
        return {
          "border": Color(0xffb54b00),
          "background": Color(0xffb54b00).withOpacity(0.2)
        };
      default:
        return {
          "border": Colors.white,
          "background": Colors.white.withOpacity(0.2)
        };
    }
  }
}
