import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/settings/obs_settings.dart';
import 'package:irllink/src/domain/usecases/obs/get_obs_credentials_usecase.dart';
import 'package:irllink/src/domain/usecases/obs/update_obs_url_usecase.dart';

class ObsSettingsController extends GetxController {
  final SettingsService settingsService = Get.find<SettingsService>();

  ObsSettingsController({
    required this.getObsCredentialsUsecase,
    required this.updateObsSettingsUsecase,
  });

  final GetObsCredentialsUsecase getObsCredentialsUsecase;
  final UpdateObsSettingsUsecase updateObsSettingsUsecase;

  RxBool obsWebsocketPasswordShow = false.obs;
  RxBool obsWebsocketUrlShow = false.obs;
  late TextEditingController obsWebsocketUrlFieldController;
  late TextEditingController obsWebsocketPasswordFieldController;

  Rxn<ObsSettings> obsSettings = Rxn<ObsSettings>();

  @override
  void onInit() {
    super.onInit();

    obsWebsocketUrlFieldController = TextEditingController();
    obsWebsocketPasswordFieldController = TextEditingController();

    getObsCredentials();
  }

  @override
  void onClose() {
    obsWebsocketUrlFieldController.dispose();
    obsWebsocketPasswordFieldController.dispose();
    super.onClose();
  }

  void getObsCredentials() async {
    final result = await getObsCredentialsUsecase(params: null);
    result.fold(
      (failure) {},
      (success) {
        obsSettings.value = success;
        obsWebsocketUrlFieldController.text = success.url;
        obsWebsocketPasswordFieldController.text = success.password;
      },
    );
  }

  void toggleObsConnection() async {
    final result = await updateObsSettingsUsecase(
      params: ObsSettings(
        url: obsSettings.value?.url ?? '',
        password: obsSettings.value?.password ?? '',
        isConnected: !(obsSettings.value?.isConnected ?? false),
      ),
    );
    result.fold(
      (failure) {},
      (success) {},
    );
    getObsCredentials();
  }

  void updateObsUrl(String url) async {
    final result = await updateObsSettingsUsecase(
      params: ObsSettings(
        url: url,
        password: obsSettings.value?.password ?? '',
        isConnected: obsSettings.value?.isConnected ?? false,
      ),
    );
    result.fold(
      (failure) {},
      (success) {},
    );
    getObsCredentials();
  }

  void updateObsPassword(String password) async {
    final result = await updateObsSettingsUsecase(
      params: ObsSettings(
        url: obsSettings.value?.url ?? '',
        password: password,
        isConnected: obsSettings.value?.isConnected ?? false,
      ),
    );
    result.fold(
      (failure) {},
      (success) {},
    );
    getObsCredentials();
  }
}
