import 'package:flutter/material.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/timestamp.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/author_name.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/word.dart';
import 'package:kick_chat/kick_chat.dart';

class KickMessageRow extends StatelessWidget {
  final KickMessage message;
  final bool displayTimestamp;
  final double textSize;

  const KickMessageRow({
    super.key,
    required this.message,
    required this.displayTimestamp,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Visibility(
          visible: displayTimestamp,
          child: Container(
            padding: const EdgeInsets.only(right: 5),
            child: Timestamp(
              timestamp: int.parse(message.data.createdAt),
            ),
          ),
        ),
        for (UserBadge badge in message.data.sender.identity.badges)
          Container(
            padding: const EdgeInsets.only(right: 4, top: 3),
            child: Image(
              image: NetworkImage(badge.text),
              filterQuality: FilterQuality.high,
            ),
          ),
        AuthorName(
          isAction: false,
          username: message.data.sender.username,
          displayName: message.data.sender.username,
          color: message.data.sender.identity.color,
          textSize: textSize,
        ),
        for (Widget i in messageContent(
          message,
          textSize,
        ))
          i,
      ],
    );
  }

  List<Widget> messageContent(
    final KickMessage message,
    final double textSize,
  ) {
    List<Widget> messageWidgetsBuild = [];

    for (int i = 0; i < message.data.content.trim().split(' ').length; i++) {
      String word =  message.data.content.trim().split(' ')[i];

        messageWidgetsBuild.add(
          Word(
            word: word,
            isAction: false,
            color: 'white',
            textSize: textSize,
          ),
        );
    }

    return messageWidgetsBuild;
  }
}
