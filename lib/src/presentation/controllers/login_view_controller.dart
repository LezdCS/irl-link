import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/core/params/kick_auth_params.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/domain/entities/kick/kick_credentials.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/usecases/kick/get_kick_local_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/kick_refresh_token_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/login_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/logout_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/get_twitch_local_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/login_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/logout_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/refresh_token_usecase.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';

class LoginViewController extends GetxController {
  LoginViewController({
    required this.getTwitchLocalUseCase,
    required this.refreshTwitchTokenUseCase,
    required this.kickRefreshTokenUseCase,
    required this.loginUseCase,
    required this.loginKickUseCase,
    required this.getKickLocalUseCase,
    required this.logoutTwitchUseCase,
    required this.logoutKickUseCase,
  });

  final GetTwitchLocalUseCase getTwitchLocalUseCase;
  final RefreshTwitchTokenUseCase refreshTwitchTokenUseCase;
  final KickRefreshTokenUseCase kickRefreshTokenUseCase;
  final LoginUseCase loginUseCase;
  final LoginKickUseCase loginKickUseCase;
  final GetKickLocalUseCase getKickLocalUseCase;
  final LogoutUseCase logoutTwitchUseCase;
  final LogoutKickUseCase logoutKickUseCase;

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

    Future<TwitchCredentials?> handleTwitchCredentials() async {
      final twitchCredsResult = await getTwitchLocalUseCase();
      return await twitchCredsResult.fold(
        (l) async => null, // Do nothing if no Twitch credentials found
        (r) async {
          loadingMessage.value = "refreshing_token".tr;
          twitchCredentials.value = r;
          final refreshResult = await refreshTwitchTokenUseCase(params: r);
          return refreshResult.fold(
            (l) async {
              await logoutTwitchUseCase(params: r.accessToken);
              return null;
            },
            (r) async {
              twitchCredentials.value = r;
              return r;
            },
          );
        },
      );
    }

    Future<KickCredentials?> handleKickCredentials() async {
      final kickCredsResult = await getKickLocalUseCase();
      return await kickCredsResult.fold(
        (l) async => null,
        (r) async {
          loadingMessage.value = "refreshing_token".tr;
          kickCredentials.value = r;
          final refreshResult = await kickRefreshTokenUseCase(params: r);
          return refreshResult.fold(
            (l) async {
              await logoutKickUseCase(params: r.accessToken);
              return null;
            },
            (r) async {
              kickCredentials.value = r;
              return r;
            },
          );
        },
      );
    }

    // Run credential handling in parallel
    final results = await Future.wait([
      handleTwitchCredentials(),
      handleKickCredentials(),
    ]);

    twitchCredentials.value = results[0] as TwitchCredentials?;
    kickCredentials.value = results[1] as KickCredentials?;

    if (twitchCredentials.value != null || kickCredentials.value != null) {
      await Get.offAllNamed(
        Routes.home,
        arguments: [
          twitchCredentials.value,
          kickCredentials.value,
        ],
      );
    }

    // If we haven't navigated away yet (no valid credentials), stop loading
    if (!Get.isRegistered<HomeViewController>()) {
      isLoading.value = false;
    }

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
        Get.offAllNamed(Routes.home, arguments: [r, null]);
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
        Get.offAllNamed(Routes.home, arguments: [null, r]);
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
