import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerScreenView extends StatelessWidget {
  final Talker talker;

  const TalkerScreenView({
    super.key,
    required this.talker,
  });

  @override
  Widget build(BuildContext context) {
    return TalkerScreen(
      appBarTitle: 'Logs',
      talker: talker,
      theme: const TalkerScreenTheme(
        backgroundColor: Color(0xFF0e0e10),
        cardColor: Color(0xFF18181b),
      ),
    );
  }
}
