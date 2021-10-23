import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irl_link/views/homeView.dart';
import 'package:flutter/services.dart';

class LoginViewController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    // Here you can fetch you product from server
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // Here, you can dispose your StreamControllers
    // you can cancel timers
    super.onClose();
  }

  void login() {
    box.write('twitchToken', 'TOKENtoGET');
    Get.offAll(HomeView());
  }
}
