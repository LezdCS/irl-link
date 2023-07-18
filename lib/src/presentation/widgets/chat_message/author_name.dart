import 'package:flutter/material.dart';

class AuthorName extends StatelessWidget {
  final bool isAction;
  final String displayName;
  final String color;
  final double textSize;

  const AuthorName({
    super.key,
    required this.isAction,
    required this.displayName,
    required this.color,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: displayName,
        style: TextStyle(
          color: Color(int.parse(color.replaceAll('#', '0xff'))),
          fontSize: textSize,
          fontWeight: FontWeight.bold,
        ),
        children: [
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
