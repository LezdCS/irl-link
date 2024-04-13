import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';

class AuthorName extends StatelessWidget {
  final bool isAction;
  final String username;
  final String displayName;
  final String color;
  final double textSize;
  final Platform platform;

  const AuthorName({
    super.key,
    required this.isAction,
    required this.username,
    required this.displayName,
    required this.color,
    required this.textSize,
    required this.platform,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: username != displayName.toLowerCase() ? username : displayName,
        style: TextStyle(
          color: Color(int.parse(color.replaceAll('#', '0xff'))),
          fontSize: textSize,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: username != displayName.toLowerCase() && platform == Platform.twitch ? "($displayName)" : "",
            style: TextStyle(
              color: Color(int.parse(color.replaceAll('#', '0xff'))),
              fontSize: textSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          TextSpan(
            text: isAction ? " " : ": ",
            style: TextStyle(
              color: Colors.white,
              fontSize: textSize,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
