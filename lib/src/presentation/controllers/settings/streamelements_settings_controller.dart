import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/usecases/streamelements/disconnect_usecase.dart'
    show StreamElementsDisconnectUseCase;
import 'package:irllink/src/domain/usecases/streamelements/login_usecase.dart'
    show StreamElementsLoginUseCase;
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';

class StreamelementsSettingsController extends GetxController {
  StreamelementsSettingsController({
    required this.streamElementsLoginUseCase,
    required this.streamElementsDisconnectUseCase,
    required this.settingsService,
    required this.homeViewController,
    required this.storeService,
  });

  late TextEditingController seJwtInputController;
  late TextEditingController seOverlayTokenInputController;
  final StreamElementsLoginUseCase streamElementsLoginUseCase;
  final StreamElementsDisconnectUseCase streamElementsDisconnectUseCase;

  final HomeViewController homeViewController;

  final StoreService storeService;
  final SettingsService settingsService;

  RxBool seJwtShow = false.obs;
  RxBool seOverlayTokenShow = false.obs;
  @override
  void onInit() {
    super.onInit();
    Settings settings = settingsService.settings.value;
    seJwtInputController =
        TextEditingController(text: settings.streamElementsSettings.jwt);
    seOverlayTokenInputController = TextEditingController(
      text: settings.streamElementsSettings.overlayToken,
    );
  }

  Future<void> loginStreamElements() async {
    if (!storeService.isSubscribed()) {
      Get.snackbar(
        "Error",
        "You are not subscribed",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error_outline, color: Colors.red),
        borderWidth: 1,
        borderColor: Colors.red,
      );
      return;
    }
    StreamelementsAuthParams params = const StreamelementsAuthParams();
    final loginResult = await streamElementsLoginUseCase(params: params);
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
        homeViewController.generateTabs();

        Get.snackbar(
          "StreamElements",
          "Login successfull",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.check, color: Colors.green),
          borderWidth: 1,
          borderColor: Colors.green,
        );
      },
    );
  }

  Future<void> disconnectStreamElements() async {
    if (homeViewController
            .streamelementsViewController.value?.seCredentials.value ==
        null) {
      return;
    }
    final result = await streamElementsDisconnectUseCase(
      params: homeViewController
          .streamelementsViewController.value!.seCredentials.value!.accessToken,
    );

    result.fold(
      (l) => debugPrint(l.message),
      (r) {
        Get.snackbar(
          "StreamElements",
          "Successfully disconnected.",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.check, color: Colors.green),
          borderWidth: 1,
          borderColor: Colors.green,
        );
        homeViewController.generateTabs();
      },
    );
  }
}
