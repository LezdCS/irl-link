import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_user.dart';
import 'package:irllink/src/domain/usecases/streamelements/disconnect_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/login_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/get_twitch_users_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/logout_usecase.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:uuid/uuid.dart';

class SettingsViewController extends GetxController {
  SettingsViewController({
    required this.logoutUseCase,
    required this.streamElementsLoginUseCase,
    required this.streamElementsDisconnectUseCase,
    required this.getTwitchUsersUseCase,
  });

  final LogoutUseCase logoutUseCase;
  final StreamElementsLoginUseCase streamElementsLoginUseCase;
  final StreamElementsDisconnectUseCase streamElementsDisconnectUseCase;
  final GetTwitchUsersUseCase getTwitchUsersUseCase;

  final SettingsService settingsService = Get.find<SettingsService>();

  late TextEditingController addBrowserTitleController;
  late TextEditingController addBrowserUrlController;
  late TextEditingController addHiddenUsernameController;
  late RxBool addBrowserToggled = true.obs;
  late RxBool addBrowserAudioSourceToggled = false.obs;

  final addBrowserUrlKey = GlobalKey<FormState>();
  final addBrowserTitleKey = GlobalKey<FormState>();

  late RxList<String> usernamesHiddenUsers;

  RxBool obsWebsocketPasswordShow = false.obs;
  RxBool obsWebsocketUrlShow = false.obs;
  RxBool seJwtShow = false.obs;
  RxBool seOverlayTokenShow = false.obs;
  RxBool rtIrlKeyShow = false.obs;
  late TextEditingController obsWebsocketUrlFieldController;
  late TextEditingController obsWebsocketPasswordFieldController;
  late TextEditingController seJwtInputController;
  late TextEditingController seOverlayTokenInputController;
  late TextEditingController rtIrlInputController;

  late TextEditingController addTtsIgnoredUsersController;
  late TextEditingController addTtsIgnoredPrefixsController;
  late TextEditingController addTtsAllowedPrefixsController;
  Rx<Color> nothingJustToRefreshDialog = Colors.grey.obs;

  final HomeViewController homeViewController = Get.find<HomeViewController>();
  final TtsService ttsService = Get.find<TtsService>();
  final StoreService storeService = Get.find<StoreService>();

  @override
  void onInit() {
    Settings settings = settingsService.settings.value;

    obsWebsocketUrlFieldController =
        TextEditingController(text: settings.obsWebsocketUrl);
    obsWebsocketPasswordFieldController =
        TextEditingController(text: settings.obsWebsocketPassword);
    addBrowserTitleController = TextEditingController();
    addBrowserUrlController = TextEditingController();
    addHiddenUsernameController = TextEditingController();
    addTtsIgnoredUsersController = TextEditingController();
    addTtsIgnoredPrefixsController = TextEditingController();
    addTtsAllowedPrefixsController = TextEditingController();
    seJwtInputController =
        TextEditingController(text: settings.streamElementsSettings.jwt);
    seOverlayTokenInputController = TextEditingController(
        text: settings.streamElementsSettings.overlayToken);
    rtIrlInputController = TextEditingController(text: settings.rtIrlPushKey);

    usernamesHiddenUsers = <String>[].obs;
    super.onInit();
  }

  @override
  void onReady() {
    if (homeViewController.twitchData != null) {
      getUsernames();
    }

    super.onReady();
  }

  void logout() {
    logoutUseCase(params: homeViewController.twitchData!.accessToken).then(
      (value) => Get.offAllNamed(Routes.login),
    );
  }

  void login() {
    Get.offAllNamed(Routes.login);
  }

  List<dynamic> getVoiceForLanguage(String language) {
    return ttsService.ttsVoices.where((v) => v['locale'] == language).toList();
  }

  Future<void> loginStreamElements() async {
    if (Get.find<StoreService>().isSubscribed() == false) {
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
    await streamElementsLoginUseCase(params: params).then((value) {
      if (value is DataFailed) {
        Get.snackbar(
          "Error",
          "Login failed: ${value.error}",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.error_outline, color: Colors.red),
          borderWidth: 1,
          borderColor: Colors.red,
        );
      } else {
        homeViewController.generateTabs();
        Get.snackbar(
          "StreamElements",
          "Login successfull",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.check, color: Colors.green),
          borderWidth: 1,
          borderColor: Colors.green,
        );
      }
    });
  }

  Future<void> disconnectStreamElements() async {
    if (homeViewController
            .streamelementsViewController.value?.seCredentials.value ==
        null) return;
    DataState<void> result = await streamElementsDisconnectUseCase(
      params: homeViewController
          .streamelementsViewController.value!.seCredentials.value!.accessToken,
    );
    if (result is DataSuccess) {
      Get.snackbar(
        "StreamElements",
        "Successfully disconnected.",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.check, color: Colors.green),
        borderWidth: 1,
        borderColor: Colors.green,
      );
      homeViewController.generateTabs();
    } else {
      Get.snackbar(
        "Error",
        "Logout failed: ${result.error}",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error_outline, color: Colors.red),
        borderWidth: 1,
        borderColor: Colors.red,
      );
    }
  }

  void removeHiddenUser(userId) {
    Settings settings = settingsService.settings.value;

    List hiddenUsersIds = settings.hiddenUsersIds;
    hiddenUsersIds.remove(userId);
    settingsService.settings.value =
        settings.copyWith(hiddenUsersIds: hiddenUsersIds);
    settingsService.saveSettings();
  }

  void addBrowserTab() {
    bool isValid = false;
    isValid = addBrowserTitleKey.currentState!.validate();
    isValid = addBrowserUrlKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    String title = addBrowserTitleController.text;
    String url = addBrowserUrlController.text;
    bool toggled = addBrowserToggled.value;
    bool audioSourceToggled = addBrowserAudioSourceToggled.value;

    var uuid = const Uuid();

    BrowserTab tab = BrowserTab(
      id: uuid.v4(),
      title: title,
      url: url,
      toggled: toggled,
      iOSAudioSource: audioSourceToggled,
    );
    Settings settings = settingsService.settings.value;

    List<BrowserTab> tabs = List.from(settings.browserTabs.tabs);
    tabs.add(tab);
    settingsService.settings.value = settings.copyWith(
      browserTabs: settings.browserTabs.copyWith(tabs: tabs),
    );
    settingsService.saveSettings();

    Get.back();
  }

  void editBrowserTab(BrowserTab tab) {
    bool isValid = false;
    isValid = addBrowserTitleKey.currentState!.validate();
    isValid = addBrowserUrlKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    String title = addBrowserTitleController.text;
    String url = addBrowserUrlController.text;
    bool toggled = addBrowserToggled.value;
    bool audioSourceToggled = addBrowserAudioSourceToggled.value;
    BrowserTab newTab = BrowserTab(
      id: tab.id,
      title: title,
      url: url,
      toggled: toggled,
      iOSAudioSource: audioSourceToggled,
    );

    Settings settings = settingsService.settings.value;

    List<BrowserTab> tabs = settings.browserTabs.tabs;
    int index = tabs.indexWhere((element) => element.id == tab.id);
    tabs[index] = newTab;
    settingsService.settings.value = settings.copyWith(
      browserTabs: settings.browserTabs.copyWith(tabs: tabs),
    );

    settingsService.saveSettings();

    // Close the dialog
    Get.back();
  }

  void removeBrowserTab(tab) {
    Settings settings = settingsService.settings.value;

    List<BrowserTab> tabs = settings.browserTabs.tabs;
    tabs.remove(tab);

    settingsService.settings.value = settings.copyWith(
      browserTabs: settings.browserTabs.copyWith(tabs: tabs),
    );
    settingsService.saveSettings();

    Get.back();
  }

  Future getUsernames() async {
    List<TwitchUser> users = [];
    Settings settings = settingsService.settings.value;

    await getTwitchUsersUseCase(
      params: GetTwitchUsersUseCaseParams(
        ids: settings.hiddenUsersIds,
        accessToken: homeViewController.twitchData!.accessToken,
      ),
    ).then((value) => users = value.data!);

    for (var user in users) {
      usernamesHiddenUsers.add(user.displayName);
    }
  }
}
