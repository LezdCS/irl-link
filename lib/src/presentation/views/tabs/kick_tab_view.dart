import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irllink/src/presentation/controllers/kick_tab_view_controller.dart';

class KickTabView extends GetView<KickTabViewController> {
  const KickTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Text("Kick"),
        ],
      ),
    );
  }
}
