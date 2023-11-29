import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:irllink/src/presentation/events/home_events.dart';

class KickChatViewController extends GetxController {
  KickChatViewController({
    required this.homeEvents,
    required this.chatroomId,
  });

  final HomeEvents homeEvents;
  final String chatroomId;
}
