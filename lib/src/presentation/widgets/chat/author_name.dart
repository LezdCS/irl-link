import 'package:flutter/material.dart';

class AuthorName extends StatelessWidget {

  final bool isAction;
  final String authorName;
  final String color;
  final double textSize;

  AuthorName({
    required this.isAction,
    required this.authorName,
    required this.color,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      isAction
          ? authorName + " "
          : authorName + ": ",
      style: TextStyle(
        color:
        Color(int.parse(color.replaceAll('#', '0xff'))),
        fontSize: textSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
