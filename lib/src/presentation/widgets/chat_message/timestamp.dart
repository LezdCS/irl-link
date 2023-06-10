import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Timestamp extends StatelessWidget {
  final int timestamp;

  Timestamp({
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(timestamp)),
      textAlign: TextAlign.end,
      style: const TextStyle(
          color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
    );
  }
}
