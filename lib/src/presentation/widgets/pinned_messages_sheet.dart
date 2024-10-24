import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irllink/src/domain/entities/pinned_message.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/author_name.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/timestamp.dart';

class PinnedMessagesSheet extends GetView {
  const PinnedMessagesSheet({
    super.key,
    required this.messages,
  });

  final List<PinnedMessage> messages;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 5),
                    child: Timestamp(
                      timestamp: message.timestamp,
                    ),
                  ),
                  AuthorName(
                    isAction: false,
                    username: message.displayName,
                    displayName: message.displayName,
                    color: message.color,
                    textSize: 18,
                    platform: message.platform,
                  ),
                  Text(message.message),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
