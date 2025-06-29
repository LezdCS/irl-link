import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/params/kick_auth_params.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/speaker_service.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/usecases/kick/login_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/logout_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/get_twitch_users_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/login_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/logout_usecase.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';

class SettingsViewController extends GetxController {
  SettingsViewController({
    required this.logoutUseCase,
    required this.loginUseCase,
    required this.getTwitchUsersUseCase,
    required this.settingsService,
    required this.homeViewController,
    required this.ttsService,
    required this.storeService,
    required this.logoutKickUseCase,
    required this.loginKickUseCase,
  });

  final LogoutUseCase logoutUseCase;
  final LoginUseCase loginUseCase;
  final GetTwitchUsersUseCase getTwitchUsersUseCase;
  final LogoutKickUseCase logoutKickUseCase;
  final LoginKickUseCase loginKickUseCase;

  final SettingsService settingsService;
  final HomeViewController homeViewController;
  final TtsService ttsService;
  final StoreService storeService;

  RxBool obsWebsocketPasswordShow = false.obs;
  RxBool obsWebsocketUrlShow = false.obs;
  RxBool rtIrlKeyShow = false.obs;
  late TextEditingController obsWebsocketUrlFieldController;
  late TextEditingController obsWebsocketPasswordFieldController;
  late TextEditingController seJwtInputController;
  late TextEditingController seOverlayTokenInputController;
  late TextEditingController rtIrlInputController;

  @override
  void onInit() {
    Settings settings = settingsService.settings.value;

    obsWebsocketUrlFieldController =
        TextEditingController(text: settings.obsWebsocketUrl);
    obsWebsocketPasswordFieldController =
        TextEditingController(text: settings.obsWebsocketPassword);
    rtIrlInputController = TextEditingController(text: settings.rtIrlPushKey);

    super.onInit();
  }

  void updateKeepSpeakerOn({required bool value}) {
    settingsService.settings.value = settingsService.settings.value.copyWith(
      generalSettings: settingsService.settings.value.generalSettings.copyWith(
        keepSpeakerOn: value,
      ),
    );
    settingsService.saveSettings();

    if (Get.isRegistered<SpeakerService>()) {
      Get.find<SpeakerService>().updateSettings(settingsService.settings.value);
    }
  }

  Future<void> logout() async {
    if (homeViewController.twitchData.value == null) {
      return;
    }

    final logoutResult = await logoutUseCase(
      params: homeViewController.twitchData.value!.accessToken,
    );

    logoutResult.fold(
      (l) {
        Get.snackbar(
          "Error",
          "Logout failed: $l",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.error_outline, color: Colors.red),
          borderWidth: 1,
          borderColor: Colors.red,
        );
      },
      (r) {
        homeViewController.twitchData.value = null;
        Get.snackbar(
          "Twitch",
          "Successfully logged out",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.check, color: Colors.green),
          borderWidth: 1,
          borderColor: Colors.green,
        );
      },
    );
  }

  Future<void> login() async {
    final loginResult = await loginUseCase(
      params: const TwitchAuthParams(),
    );

    loginResult.fold(
      (l) {
        Get.snackbar(
          "Error",
          "Login failed: $l",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.error_outline, color: Colors.red),
          borderWidth: 1,
          borderColor: Colors.red,
        );
      },
      (r) {
        homeViewController.twitchData.value = r;
        Get.snackbar(
          "Twitch",
          "Successfully logged in",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.check, color: Colors.green),
          borderWidth: 1,
          borderColor: Colors.green,
        );
      },
    );
  }

  Future<void> loginKick() async {
    final loginResult = await loginKickUseCase(
      params: KickAuthParams.withPKCE(),
    );

    loginResult.fold(
      (l) {
        Get.snackbar(
          "Error",
          "Login failed: $l",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.error_outline, color: Colors.red),
          borderWidth: 1,
          borderColor: Colors.red,
        );
      },
      (r) {
        homeViewController.kickData.value = r;
        Get.snackbar(
          "Kick",
          "Successfully logged in",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.check, color: Colors.green),
          borderWidth: 1,
          borderColor: Colors.green,
        );
      },
    );
  }

  List<dynamic> getVoiceForLanguage(String language) {
    return ttsService.ttsVoices.where((v) => v['locale'] == language).toList();
  }

  Future<void> logoutKick() async {
    if (homeViewController.kickData.value == null) {
      return;
    }

    final logoutResult = await logoutKickUseCase(
      params: homeViewController.kickData.value!.accessToken,
    );

    logoutResult.fold(
      (l) {
        Get.snackbar(
          "Error",
          "Logout failed: $l",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.error_outline, color: Colors.red),
          borderWidth: 1,
          borderColor: Colors.red,
        );
      },
      (r) {
        homeViewController.kickData.value = null;
        Get.snackbar(
          "Kick",
          "Successfully logged out",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.check, color: Colors.green),
          borderWidth: 1,
          borderColor: Colors.green,
        );
      },
    );
  }
}
