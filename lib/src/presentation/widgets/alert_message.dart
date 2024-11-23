import 'package:flutter/material.dart';

Widget alertMessage({
  required Color color,
  required String message,
  required bool isProgress,
}) {
  return AnimatedContainer(
    padding: const EdgeInsets.only(bottom: 5, top: 5),
    color: color,
    duration: const Duration(milliseconds: 400),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Visibility(
          visible: isProgress,
          child: Container(
            margin: const EdgeInsets.only(left: 8),
            width: 20,
            height: 20,
            child: const CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
