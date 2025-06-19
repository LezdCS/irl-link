import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/domain/usecases/settings/add_browser_tab_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/edit_browser_tab_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/get_browser_tabs_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/remove_browser_tab_usecase.dart';
import 'package:uuid/uuid.dart';

class BrowserSettingsController extends GetxController {
  BrowserSettingsController({
    required this.talkerService,
    required this.addBrowserTabUsecase,
    required this.editBrowserTabUsecase,
    required this.removeBrowserTabUsecase,
    required this.getBrowserTabsUsecase,
  });

  final TalkerService talkerService;
  final AddBrowserTabUsecase addBrowserTabUsecase;
  final EditBrowserTabUsecase editBrowserTabUsecase;
  final RemoveBrowserTabUsecase removeBrowserTabUsecase;
  final GetBrowserTabsUsecase getBrowserTabsUsecase;

  late TextEditingController addBrowserTitleController;
  late TextEditingController addBrowserUrlController;
  late TextEditingController addHiddenUsernameController;
  late RxBool addBrowserToggled = true.obs;
  late RxBool addBrowserAudioSourceToggled = false.obs;

  final addBrowserUrlKey = GlobalKey<FormState>();
  final addBrowserTitleKey = GlobalKey<FormState>();

  final RxList<BrowserTab> browserTabs = <BrowserTab>[].obs;

  @override
  void onInit() {
    super.onInit();
    addBrowserTitleController = TextEditingController();
    addBrowserUrlController = TextEditingController();
    addHiddenUsernameController = TextEditingController();

    getBrowserTabs();
  }

  Future<void> getBrowserTabs() async {
    final browserTabsResult = await getBrowserTabsUsecase(params: null);
    browserTabsResult.fold((l) {
      talkerService.talker.error('Failed to get browser tabs: $l');
    }, (r) {
      browserTabs.value = r;
    });
  }

  Future<void> addBrowserTab() async {
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

    await addBrowserTabUsecase(params: tab);
    await getBrowserTabs();
    Get.back();
  }

  Future<void> editBrowserTab(BrowserTab tab) async {
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

    await editBrowserTabUsecase(params: newTab);

    // Close the dialog
    await getBrowserTabs();
    Get.back();
  }

  Future<void> removeBrowserTab(BrowserTab tab) async {
    await removeBrowserTabUsecase(params: tab);

    await getBrowserTabs();
    Get.back();
  }
}
