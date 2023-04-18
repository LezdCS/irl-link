import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/events/settings_events.dart';

import '../../domain/entities/twitch_credentials.dart';
import '../../domain/entities/twitch_user.dart';

class SettingsViewController extends GetxController {
  SettingsViewController({required this.settingsEvents});

  final SettingsEvents settingsEvents;

  late Rx<Settings> settings = Settings.defaultSettings().obs;

  late TextEditingController alternateChannelChatController;
  late TextEditingController obsWebsocketUrlFieldController;
  late TextEditingController obsWebsocketPasswordFieldController;
  late TextEditingController addBrowserTitleController;
  late TextEditingController addBrowserUrlController;
  late TextEditingController addHiddenUsernameController;

  final addBrowserUrlKey = GlobalKey<FormState>();
  final addBrowserTitleKey = GlobalKey<FormState>();
  final addHiddenUserKey = GlobalKey<FormState>();

  TwitchCredentials? twitchData;

  late RxList<String> usernamesHiddenUsers;

  RxBool obsWebsocketPasswordShow = false.obs;
  RxBool obsWebsocketUrlShow = false.obs;

  RxList ttsLanguages = [].obs;
  RxList ttsVoices = [].obs;

  @override
  void onInit() {
    alternateChannelChatController = TextEditingController();
    obsWebsocketUrlFieldController = TextEditingController();
    obsWebsocketPasswordFieldController = TextEditingController();
    addBrowserTitleController = TextEditingController();
    addBrowserUrlController = TextEditingController();
    addHiddenUsernameController = TextEditingController();

    if (Get.arguments != null) {
      twitchData = Get.arguments[0];
    }
    usernamesHiddenUsers = <String>[].obs;
    getTtsLanguages();
    getTtsVoices();
    super.onInit();
  }

  @override
  void onReady() {
    if (twitchData != null) {
      settingsEvents.getSettings().then((value) => {
            if (value.error == null)
              {
                settings.value = value.data!,
                alternateChannelChatController.text =
                    settings.value.alternateChannelName!,
                obsWebsocketUrlFieldController.text =
                    settings.value.obsWebsocketUrl!,
                obsWebsocketPasswordFieldController.text =
                    settings.value.obsWebsocketPassword!,
                getUsernames(),
              }
          });
    }

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void logout() {
    settingsEvents.logout(accessToken: twitchData!.accessToken).then(
          (value) => Get.offAllNamed(Routes.LOGIN),
        );
  }

  void login() {
    Get.offAllNamed(Routes.LOGIN);
  }

  void removeHiddenUser(userId) {
    List hiddenUsersIds = settings.value.hiddenUsersIds!;
    hiddenUsersIds.remove(userId);
    settings.value = settings.value.copyWith(hiddenUsersIds: hiddenUsersIds);
    saveSettings();
    settings.refresh();
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
    Map<String, String> tab = {'title': title, 'url': url};
    List browserTabs = settings.value.browserTabs! == const []
        ? []
        : settings.value.browserTabs!;
    browserTabs.add(tab);
    settings.value = settings.value.copyWith(browserTabs: browserTabs);
    saveSettings();
    settings.refresh();
    Get.back();
  }

  void editBrowserTab(elem) {
    bool isValid = false;
    isValid = addBrowserTitleKey.currentState!.validate();
    isValid = addBrowserUrlKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    String title = addBrowserTitleController.text;
    String url = addBrowserUrlController.text;
    elem["title"] = title;
    elem["url"] = url;
    List browserTabs = settings.value.browserTabs! == const []
        ? []
        : settings.value.browserTabs!;
    settings.value = settings.value.copyWith(browserTabs: browserTabs);
    saveSettings();
    settings.refresh();
    Get.back();
  }

  void removeBrowserTab(tab) {
    List tabs = settings.value.browserTabs!;
    tabs.remove(tab);
    settings.value = settings.value.copyWith(browserTabs: tabs);
    saveSettings();
    settings.refresh();
  }

  void saveSettings() {
    settingsEvents.setSettings(settings: settings.value);
  }

  Future getUsernames() async {
    List<TwitchUser> users = [];

    await settingsEvents
        .getTwitchUsers(
            ids: settings.value.hiddenUsersIds!,
            accessToken: twitchData!.accessToken)
        .then((value) => users = value.data!);

    users.forEach((user) => usernamesHiddenUsers.add(user.displayName));
  }

  void getTtsLanguages() {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.getLanguages.then((value) => {
          ttsLanguages.value = value,
          ttsLanguages.sort((a, b) => a.compareTo(b))
        });
  }

  void getTtsVoices() {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.getVoices.then((value) => {
          ttsVoices.value = value,
          ttsVoices.sort((a, b) => a['name'].compareTo(b['name']))
        });
  }
}
