import 'package:flutter/material.dart';
import 'package:irllink/src/presentation/widgets/chat_message/kick/kick_message_row.dart';
import 'package:kick_chat/kick_chat.dart';

class KickEventContainer extends StatelessWidget {
  final KickMessage message;
  final bool displayTimestamp;
  final double textSize;

  const KickEventContainer({
    super.key,
    required this.message,
    required this.displayTimestamp,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = getColorFromType(message.event)["border"];
    return Container(
      padding: const EdgeInsets.only(top: 2, bottom: 2, left: 5),
      decoration: BoxDecoration(
        color: getColorFromType(message.event)["background"],
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
              getIconFromType(message.event),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  getStringFromType(message.event, message),
                  style: TextStyle(color: Colors.grey[300], fontSize: 16),
                ),
              ),
            ],
          ),
          message.data.content != ''
              ? KickMessageRow(
                  message: message,
                  displayTimestamp: displayTimestamp,
                  textSize: textSize,
                )
              : Container(),
        ],
      ),
    );
  }

  String getStringFromType(TypeEvent type, KickMessage message) {
    switch (type) {
      case TypeEvent.followersUpdated:
        return "${message.data.sender.username} is now following!";
      default:
        return "Unsupported event";
    }
  }

  Map<String, dynamic> getColorFromType(TypeEvent type) {
    switch (type) {
      case TypeEvent.followersUpdated:
        return {
          "border": const Color(0xff486d1a),
          "background": const Color(0xff486d1a).withOpacity(0.2)
        };
      default:
        return {
          "border": Colors.black,
          "background": Colors.black.withOpacity(0.2)
        };
    }
  }

  Icon getIconFromType(TypeEvent type) {
    switch (type) {
      case TypeEvent.followersUpdated:
        return const Icon(Icons.star);
      default:
        return const Icon(Icons.auto_awesome);
    }
  }
}
