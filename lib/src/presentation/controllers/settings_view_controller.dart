import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/presentation/events/settings_events.dart';
import 'package:irllink/src/presentation/events/streamelements_events.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/twitch/twitch_user.dart';

class SettingsViewController extends GetxController {
  SettingsViewController(
      {required this.settingsEvents, required this.streamelementsEvents});

  final SettingsEvents settingsEvents;
  final StreamelementsEvents streamelementsEvents;

  late TextEditingController addBrowserTitleController;
  late TextEditingController addBrowserUrlController;
  late TextEditingController addHiddenUsernameController;
  late RxBool addBrowserToggled = true.obs;
  late RxBool addBrowserAudioSourceToggled = false.obs;

  final addBrowserUrlKey = GlobalKey<FormState>();
  final addBrowserTitleKey = GlobalKey<FormState>();
  RxList browserTabsSelected = [].obs;

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

  late HomeViewController homeViewController;
  late TtsService ttsService;
  late StoreService storeService;

  @override
  void onInit() {
    homeViewController = Get.find<HomeViewController>();
    ttsService = Get.find<TtsService>();
    storeService = Get.find<StoreService>();

    obsWebsocketUrlFieldController = TextEditingController();
    obsWebsocketPasswordFieldController = TextEditingController();
    addBrowserTitleController = TextEditingController();
    addBrowserUrlController = TextEditingController();
    addHiddenUsernameController = TextEditingController();
    addTtsIgnoredUsersController = TextEditingController();
    addTtsIgnoredPrefixsController = TextEditingController();
    addTtsAllowedPrefixsController = TextEditingController();
    seJwtInputController = TextEditingController();
    seOverlayTokenInputController = TextEditingController();
    rtIrlInputController = TextEditingController();

    usernamesHiddenUsers = <String>[].obs;
    super.onInit();
  }

  @override
  void onReady() {
    if (homeViewController.twitchData != null) {
      obsWebsocketUrlFieldController.text =
          homeViewController.settings.value.obsWebsocketUrl!;
      obsWebsocketPasswordFieldController.text =
          homeViewController.settings.value.obsWebsocketPassword!;
      seJwtInputController.text =
          homeViewController.settings.value.streamElementsSettings!.jwt ?? '';
      seOverlayTokenInputController.text = homeViewController
              .settings.value.streamElementsSettings!.overlayToken ??
          '';
      rtIrlInputController.text =
          homeViewController.settings.value.rtIrlPushKey ?? '';
      getUsernames();
    }

    super.onReady();
  }

  void logout() {
    settingsEvents
        .logout(accessToken: homeViewController.twitchData!.accessToken)
        .then(
          (value) => Get.offAllNamed(Routes.login),
        );
  }

  void login() {
    Get.offAllNamed(Routes.login);
  }

  Future<void> loginStreamElements() async {
    StreamelementsAuthParams params = const StreamelementsAuthParams();
    await streamelementsEvents.login(params: params).then((value) {
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
    DataState<void> result = await streamelementsEvents.disconnect(
      homeViewController
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
    List hiddenUsersIds = homeViewController.settings.value.hiddenUsersIds!;
    hiddenUsersIds.remove(userId);
    homeViewController.settings.value = homeViewController.settings.value
        .copyWith(hiddenUsersIds: hiddenUsersIds);
    saveSettings();
    homeViewController.settings.refresh();
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
    List<BrowserTab> tabs = homeViewController.settings.value.browserTabs!.tabs;
    tabs.add(tab);
    homeViewController.settings.value =
        homeViewController.settings.value.copyWith(
      browserTabs:
          homeViewController.settings.value.browserTabs?.copyWith(tabs: tabs),
    );
    saveSettings();
    homeViewController.settings.refresh();
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

    List<BrowserTab> tabs = homeViewController.settings.value.browserTabs!.tabs;
    int index = tabs.indexWhere((element) => element.id == tab.id);
    tabs[index] = newTab;
    homeViewController.settings.value =
        homeViewController.settings.value.copyWith(
      browserTabs:
          homeViewController.settings.value.browserTabs?.copyWith(tabs: tabs),
    );

    saveSettings();
    homeViewController.settings.refresh();

    // Close the dialog
    Get.back();
  }

  void removeBrowserTab(tab) {
    List<BrowserTab> tabs = homeViewController.settings.value.browserTabs!.tabs;
    tabs.remove(tab);

    homeViewController.settings.value =
        homeViewController.settings.value.copyWith(
      browserTabs:
          homeViewController.settings.value.browserTabs?.copyWith(tabs: tabs),
    );
    saveSettings();
    homeViewController.settings.refresh();
    Get.back();
  }

  void saveSettings() {
    settingsEvents.setSettings(settings: homeViewController.settings.value);
  }

  Future getUsernames() async {
    List<TwitchUser> users = [];

    await settingsEvents
        .getTwitchUsers(
            ids: homeViewController.settings.value.hiddenUsersIds!,
            accessToken: homeViewController.twitchData!.accessToken)
        .then((value) => users = value.data!);

    for (var user in users) {
      usernamesHiddenUsers.add(user.displayName);
    }
  }
}
