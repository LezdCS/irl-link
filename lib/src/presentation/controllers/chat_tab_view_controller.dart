import 'package:get/get.dart';
import 'package:irllink/src/presentation/events/home_events.dart';

class ChatTabViewController extends GetxController {
  ChatTabViewController({
    required this.homeEvents,
  });

  final HomeEvents homeEvents;
  RxList<dynamic> chats = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
