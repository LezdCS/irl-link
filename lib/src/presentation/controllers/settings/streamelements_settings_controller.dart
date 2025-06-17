import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/domain/usecases/streamelements/disconnect_usecase.dart'
    show StreamElementsDisconnectUseCase;
import 'package:irllink/src/domain/usecases/streamelements/get_local_credentials_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_me_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/login_usecase.dart'
    show StreamElementsLoginUseCase;

class StreamelementsSettingsController extends GetxController {
  StreamelementsSettingsController({
    required this.streamElementsLoginUseCase,
    required this.streamElementsDisconnectUseCase,
    required this.streamElementsGetLocalCredentialsUseCase,
    required this.settingsService,
    required this.storeService,
    required this.getMeUseCase,
  });

  late TextEditingController seJwtInputController;
  late TextEditingController seOverlayTokenInputController;
  final StreamElementsLoginUseCase streamElementsLoginUseCase;
  final StreamElementsDisconnectUseCase streamElementsDisconnectUseCase;
  final StreamElementsGetLocalCredentialsUseCase
      streamElementsGetLocalCredentialsUseCase;
  final StreamElementsGetMeUseCase getMeUseCase;

  final StoreService storeService;
  final SettingsService settingsService;

  final RxBool seJwtShow = false.obs;
  final RxBool seOverlayTokenShow = false.obs;
  final RxBool isLoading = false.obs;
  final Rx<SeMe?> userProfile = Rx<SeMe?>(null);
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    Settings settings = settingsService.settings.value;
    seJwtInputController =
        TextEditingController(text: settings.streamElementsSettings.jwt);
    seOverlayTokenInputController = TextEditingController(
      text: settings.streamElementsSettings.overlayToken,
    );
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    isLoading.value = true;
    final seCredentials = await streamElementsGetLocalCredentialsUseCase();
    isLoggedIn.value = seCredentials.fold((l) => false, (r) => true);
    if (isLoggedIn.value) {
      await fetchUserProfile();
    }
    isLoading.value = false;
  }

  Future<void> fetchUserProfile() async {
    final seCredentials = await streamElementsGetLocalCredentialsUseCase();
    if (seCredentials.isLeft()) {
      userProfile.value = null;
      return;
    }

    final seMeResult = await getMeUseCase(
      params: StreamElementsGetMeParams(
        token: seCredentials.fold((l) => "", (r) => r.accessToken),
      ),
    );
    userProfile.value = seMeResult.fold(
      (l) => null,
      (r) => r,
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
    isLoading.value = true;
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
        Get.snackbar(
          "StreamElements",
          "Login successfull",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.check, color: Colors.green),
          borderWidth: 1,
          borderColor: Colors.green,
        );
        checkLoginStatus();
      },
    );
    isLoading.value = false;
  }

  Future<void> disconnectStreamElements() async {
    isLoading.value = true;
    final seCredentials = await streamElementsGetLocalCredentialsUseCase();
    seCredentials.fold(
      (l) => debugPrint(l.message),
      (r) async {
        final result = await streamElementsDisconnectUseCase(
          params: r.accessToken,
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
            isLoggedIn.value = false;
            userProfile.value = null;
          },
        );
      },
    );
    isLoading.value = false;
  }
}
