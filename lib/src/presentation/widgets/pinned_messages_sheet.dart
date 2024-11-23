import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/pinned_message.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/author_name.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/timestamp.dart';

class PinnedMessagesSheet extends StatelessWidget {
  const PinnedMessagesSheet({
    super.key,
    required this.messages,
  });

  final List<PinnedMessage> messages;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFa970ff)),
        color: const Color(0xFF18181b),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
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
                  Text(message.message, style: const TextStyle(fontSize: 18)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
