import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:flutter/services.dart';
import 'package:irllink/src/presentation/events/login_events.dart';

class LoginViewController extends GetxController {
  LoginViewController({required this.loginEvents});

  final LoginEvents loginEvents;
  RxBool isLoading = true.obs;
  RxString loadingMessage = "Loading...".obs;

  @override
  Future<void> onInit() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await Future.doWhile(
        () => Future.delayed(Duration(seconds: 2)).then((_) => hasNoNetwork()));

    await loginEvents.getTwitchFromLocal().then((value) {
      if (value.error == null) {
        Get.offAllNamed(Routes.HOME, arguments: [value.data]);
      }
    }).catchError((e) {});

    isLoading.value = false;

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> login() async {
    isLoading.value = true;
    TwitchAuthParams params = TwitchAuthParams();
    await loginEvents.getTwitchOauth(params: params).then((value) {
      if (value.error == null) {
        Get.offAllNamed(Routes.HOME, arguments: [value.data]);
      }
    });
    isLoading.value = false;
  }

  Future<bool> hasNoNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return !(result.isNotEmpty && result[0].rawAddress.isNotEmpty);
    } on SocketException catch (_) {
      loadingMessage.value = "No internet connection";
      return true;
    }
  }

  void homeWitoutLogin() {
    Get.offAllNamed(Routes.HOME);
  }
}
