import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/core/params/kick_auth_params.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/domain/entities/kick/kick_credentials.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/usecases/kick/login_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/get_twitch_local_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/login_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/refresh_token_usecase.dart';

class LoginViewController extends GetxController {
  LoginViewController({
    required this.getTwitchLocalUseCase,
    required this.refreshTwitchTokenUseCase,
    required this.loginUseCase,
    required this.loginKickUseCase,
  });

  final GetTwitchLocalUseCase getTwitchLocalUseCase;
  final RefreshTwitchTokenUseCase refreshTwitchTokenUseCase;
  final LoginUseCase loginUseCase;
  final LoginKickUseCase loginKickUseCase;

  RxBool isLoading = true.obs;
  RxString loadingMessage = "retrieving_data".tr.obs;
  Rxn<TwitchCredentials> twitchCredentials = Rxn<TwitchCredentials>();
  Rxn<KickCredentials> kickCredentials = Rxn<KickCredentials>();

  @override
  Future<void> onInit() async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await Future.doWhile(
      () => Future.delayed(const Duration(seconds: 2))
          .then((_) => hasNoNetwork()),
    );

    final twitchCredsResult = await getTwitchLocalUseCase();

    twitchCredsResult.fold(
      (l) {
        isLoading.value = false;
      },
      (r) async {
        twitchCredentials.value = r;
        loadingMessage.value = "refreshing_token".tr;

        final refreshResult = await refreshTwitchTokenUseCase(params: r);

        refreshResult.fold(
          (l) {
            isLoading.value = false;
          },
          (r) {
            Get.offAllNamed(Routes.home, arguments: [r]);
          },
        );
      },
    );

    super.onReady();
  }

  Future<void> login() async {
    isLoading.value = true;
    TwitchAuthParams params = const TwitchAuthParams();
    final loginResult = await loginUseCase(params: params);

    loginResult.fold(
      (l) {
        isLoading.value = false;
      },
      (r) {
        Get.offAllNamed(Routes.home, arguments: [r]);
      },
    );
  }

  Future<void> loginKick() async {
    isLoading.value = true;
    KickAuthParams params = KickAuthParams.withPKCE();
    final loginResult = await loginKickUseCase(params: params);

    loginResult.fold(
      (l) {
        isLoading.value = false;
      },
      (r) {
        Get.offAllNamed(Routes.home, arguments: [r]);
      },
    );
  }

  Future<bool> hasNoNetwork() async {
    try {
      final result = await InternetAddress.lookup('irllink.com');
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
