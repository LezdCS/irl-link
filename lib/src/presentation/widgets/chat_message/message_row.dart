import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/chat/twitch_chat_message.dart';
import 'package:irllink/src/presentation/widgets/chat_message/timestamp.dart';
import 'package:irllink/src/presentation/widgets/chat_message/author_name.dart';
import '../../../domain/entities/twitch_badge.dart';
import '../../controllers/chat_view_controller.dart';

class MessageRow extends StatelessWidget {
  final TwitchChatMessage message;
  final ChatViewController controller;

  const MessageRow({
    required this.message,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Visibility(
          visible: controller.settings.value.displayTimestamp!,
          child: Container(
            padding: EdgeInsets.only(right: 5),
            child: Timestamp(
              timestamp: message.timestamp,
            ),
          ),
        ),
        for (TwitchBadge badge in message.badges)
          Container(
            padding: EdgeInsets.only(right: 4, top: 3),
            child: Image(
              image: NetworkImage(badge.imageUrl1x),
              filterQuality: FilterQuality.high,
            ),
          ),
        AuthorName(
          isAction: message.isAction,
          authorName: message.authorName,
          color: message.color,
          textSize: controller.settings.value.textSize!,
        ),
        if (message.isDeleted)
          Text(
            "<message deleted>",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 19,
            ),
          )
        else
          for (Widget i in message.messageWidgetsBuild) i,
      ],
    );
  }
}
