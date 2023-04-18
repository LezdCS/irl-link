import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Word extends StatelessWidget {
  final String word;
  final bool isAction;
  final double textSize;
  final String color;

  const Word({
    required this.word,
    required this.isAction,
    required this.textSize,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      word + " ",
      style: TextStyle(
        color: isAction
            ? Color(int.parse(color.replaceAll('#', '0xff')))
            : Theme.of(Get.context!).textTheme.bodyLarge!.color,
        fontSize: textSize,
        fontStyle: isAction ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }
}
