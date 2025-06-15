import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:uuid/uuid.dart';

class BrowserSettingsController extends GetxController {
  BrowserSettingsController({
    required this.settingsService,
  });

  final SettingsService settingsService;

  late TextEditingController addBrowserTitleController;
  late TextEditingController addBrowserUrlController;
  late TextEditingController addHiddenUsernameController;
  late RxBool addBrowserToggled = true.obs;
  late RxBool addBrowserAudioSourceToggled = false.obs;

  final addBrowserUrlKey = GlobalKey<FormState>();
  final addBrowserTitleKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    addBrowserTitleController = TextEditingController();
    addBrowserUrlController = TextEditingController();
    addHiddenUsernameController = TextEditingController();
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
}
