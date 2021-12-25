import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:flutter/services.dart';
import 'package:irllink/src/presentation/events/login_events.dart';

class LoginViewController extends GetxController with StateMixin<void> {
  LoginViewController({required this.loginEvents});

  final LoginEvents loginEvents;
  RxBool isOnline = true.obs;
  RxBool isLoading = true.obs;

  @override
  Future<void> onInit() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    //todo : loop hasNetwork until isOnline = true
    isOnline.value = await hasNetwork();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    if (isOnline.value) {
      await loginEvents.getTwitchFromLocal().then((value) {
        if (value.exception == null) {
          Get.offAllNamed(Routes.HOME, arguments: [value.data]);
        }
      }).catchError((e) {});
    }

    isLoading.value = false;
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
        Get.offAllNamed(Routes.HOME, arguments: [value.data]);
      }
    });
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
