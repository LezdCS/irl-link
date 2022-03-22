import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/events/settings_events.dart';

class SettingsViewController extends GetxController {
  SettingsViewController({required this.settingsEvents});

  final SettingsEvents settingsEvents;

  late Rx<Settings> settings = Settings.defaultSettings().obs;

  late TextEditingController alternateChannelChatController;
  late TextEditingController obsWebsocketUrlFieldController;
  late TextEditingController addBrowserTitleController;
  late TextEditingController addBrowserUrlController;

  final addBrowserUrlKey = GlobalKey<FormState>();
  final addBrowserTitleKey = GlobalKey<FormState>();

  @override
  void onInit() {
    alternateChannelChatController = TextEditingController();
    obsWebsocketUrlFieldController = TextEditingController();
    addBrowserTitleController = TextEditingController();
    addBrowserUrlController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    settingsEvents.getSettings().then((value) => {
          if (value.error == null)
            {
              settings.value = value.data!,
              alternateChannelChatController.text =
                  settings.value.alternateChannelName!,
              obsWebsocketUrlFieldController.text =
                  settings.value.obsWebsocketUrl!,
            }
        });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void logout() {
    settingsEvents.logout().then(
          (value) => Get.offAllNamed(Routes.LOGIN),
        );
  }

  void clearHiddenUsers() {
    settings.value = settings.value.copyWith(hiddenUsersIds: []);
    saveSettings();
  }

  void removeHiddenUser(userId) {
    List hiddenUsersIds = settings.value.hiddenUsersIds!;
    hiddenUsersIds.remove(userId);
    settings.value = settings.value.copyWith(hiddenUsersIds: hiddenUsersIds);
    saveSettings();
  }

  void addHiddenUser(String name) {}

  void addBrowserTab() {
    bool isValid = false;
    isValid = addBrowserTitleKey.currentState!.validate();
    isValid = addBrowserUrlKey.currentState!.validate();
    if (isValid) {
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

      addBrowserTitleController.text = '';
      addBrowserUrlController.text = '';
      Get.back();
    }
  }

  void injectDataToEditBrowserTab(tab) {
    addBrowserTitleController.text = tab['title'];
    addBrowserUrlController.text = tab['url'];
  }

  void removeBrowserTab(tab) {
    List tabs = settings.value.browserTabs!;
    tabs.remove(tab);
    settings.value = settings.value.copyWith(browserTabs: tabs);
    saveSettings();
    settings.refresh();
  }

  void clearBrowserTabs() {
    settings.value = settings.value.copyWith(browserTabs: []);
    saveSettings();
  }

  void saveSettings() {
    settingsEvents.setSettings(settings: settings.value);
  }
}
