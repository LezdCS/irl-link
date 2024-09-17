import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:flutter/services.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/presentation/events/login_events.dart';

class LoginViewController extends GetxController {
  LoginViewController({required this.loginEvents});

  final LoginEvents loginEvents;
  RxBool isLoading = true.obs;
  RxString loadingMessage = "Retrieving your data...".obs;
  Rxn<TwitchCredentials> twitchCredentials = Rxn<TwitchCredentials>();

  @override
  Future<void> onInit() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await Future.doWhile(() =>
        Future.delayed(const Duration(seconds: 2)).then((_) => hasNoNetwork()));

    DataState<TwitchCredentials> twitchCredsResult =
        await loginEvents.getTwitchFromLocal();

    if (twitchCredsResult is DataSuccess) {
      twitchCredentials.value = twitchCredsResult.data!;
      loadingMessage.value = "We are refreshing your token...";

      DataState<TwitchCredentials> refreshResult =
          await loginEvents.refreshAccessToken(twitchCredsResult.data!);

      isLoading.value = false;

      if (refreshResult is DataSuccess) {
        Get.offAllNamed(Routes.home, arguments: [refreshResult.data]);
      }
    }

    isLoading.value = false;

    super.onReady();
  }

  Future<void> login() async {
    isLoading.value = true;
    TwitchAuthParams params = const TwitchAuthParams();
    await loginEvents.getTwitchOauth(params: params).then((value) {
      if (value is DataSuccess) {
        Get.offAllNamed(Routes.home, arguments: [value.data]);
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
    Get.offAllNamed(Routes.home);
  }
}
