import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/core/params/twitch_request_params.dart';
import 'package:irllink/src/domain/usecases/twitch_usecase.dart';
import 'package:flutter/services.dart';
import 'package:irllink/src/presentation/views/homeView.dart';

class LoginViewController extends GetxController {
  final box = GetStorage();

  LoginViewController({required this.twitchUseCase});

  final TwitchUseCase twitchUseCase;

  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    super.onInit();
  }

  @override
  void onReady() {
    if (box.read('TwitchAccessToken') != null) {
      Get.offAllNamed(Routes.HOME);
    }

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> login() async {
    TwitchRequestParams params = TwitchRequestParams();
    await twitchUseCase.getTwitchOauth(params: params).then((value) {
      if (value.error == null) {
        Get.offAllNamed(Routes.HOME);
      }
    });
  }
}
