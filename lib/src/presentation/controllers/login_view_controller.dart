import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:flutter/services.dart';
import 'package:irllink/src/presentation/events/login_events.dart';

class LoginViewController extends GetxController {
  LoginViewController({required this.loginEvents});

  final LoginEvents loginEvents;

  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    super.onInit();
  }

  @override
  void onReady() {
    loginEvents.getTwitchFromLocal().then((value) {
      if (value.exception == null) {
        Get.offAllNamed(Routes.HOME);
      }
    }).catchError((e) {});

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> login() async {
    TwitchAuthParams params = TwitchAuthParams();
    await loginEvents.getTwitchOauth(params: params).then((value) {
      if (value.exception == null) {
        Get.offAllNamed(Routes.HOME);
      }
    });
  }
}
