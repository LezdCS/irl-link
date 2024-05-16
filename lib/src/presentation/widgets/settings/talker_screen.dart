import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerScreenView extends GetView {
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
