import 'package:get/get.dart';
import 'package:irllink/src/core/services/talker_service.dart';

class Failure {
  String message;
  Failure(this.message) {
    Get.find<TalkerService>().talker.error(message);
  }
}
