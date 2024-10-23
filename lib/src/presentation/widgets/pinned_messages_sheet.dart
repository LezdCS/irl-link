import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irllink/src/domain/entities/pinned_message.dart';

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
              return ListTile(
                title: Text(message.message),
              );
            },
          ),
        ],
      ),
    );
  }
}