import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/chat_message.dart';

// We need to have a general ChatMessage class. Then we map TwitchMessage, TwitchEvent, KickMessage and KickEvent in the ChatMessage class.
// This way we can have a single ChatView that can display all types of messages.

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
    required this.messages,
  });
  final List<ChatMessage> messages;

  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}