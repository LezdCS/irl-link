import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/utils/list_move.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/domain/usecases/kick/get_kick_local_usecase.dart';
import 'package:irllink/src/domain/usecases/rtmp/get_rtmp_list_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/get_twitch_local_usecase.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/controllers/realtime_irl_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/kick_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/rtmp_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/streamelements_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/twitch_tab_view_controller.dart';
import 'package:irllink/src/presentation/views/tabs/kick_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/obs_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/realtime_irl_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/rtmp_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/streamelements_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/twitch_tab_view.dart';
import 'package:irllink/src/presentation/widgets/web_page_view.dart';

class TabsController extends GetxController with GetTickerProviderStateMixin {
  TabsController({
    required this.settingsService,
    required this.talkerService,
    required this.getRtmpListUseCase,
    required this.getKickLocalUseCase,
    required this.getTwitchLocalUseCase,
    required this.homeViewController,
  });

  final SettingsService settingsService;
  final TalkerService talkerService;
  final GetRtmpListUseCase getRtmpListUseCase;
  final GetKickLocalUseCase getKickLocalUseCase;
  final GetTwitchLocalUseCase getTwitchLocalUseCase;
  final HomeViewController homeViewController;

  late TabController tabController;
  Rx<int> tabIndex = 0.obs;
  RxList<Widget> tabElements = <Widget>[].obs;
  RxList<WebPageView> iOSAudioSources = <WebPageView>[].obs;
  RtmpTabViewController? rtmpTabViewController;
  KickTabViewController? kickTabViewController;
  StreamelementsViewController? streamelementsViewController;
  RealtimeIrlViewController? realtimeIrlViewController;
  ObsTabViewController? obsTabViewController;
  TwitchTabViewController? twitchTabViewController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 0, vsync: this);
    generateTabs();
  }

  void reorderTabs() {
    Settings settings = Get.find<SettingsService>().settings.value;

    List<BrowserTab> tabs = settings.browserTabs.tabs
        .where((t) => t.toggled && !t.iOSAudioSource)
        .toList();
    int diff = tabElements.length - tabs.length;
    tabs.forEachIndexed((index, tab) {
      // Find the index of the tab in the tabElements list
      int indexInTabs = tabElements.indexWhere(
        (element) => element is WebPageView && element.tab.id == tab.id,
      );
      if (indexInTabs == -1) {
        return;
      }
      // Move the tab to the correct index
      tabElements.move(indexInTabs, index + diff);
    });
    tabElements.refresh();
  }

  void removeTabs() async {
    Settings settings = settingsService.settings.value;

    // Check if WebTabs have to be removed
    tabElements.removeWhere((tabElement) {
      if (tabElement is WebPageView) {
        BrowserTab? tabExist = settings.browserTabs.tabs.firstWhereOrNull(
          (settingsTab) => settingsTab.id == tabElement.tab.id,
        );
        return tabExist == null || !tabExist.toggled || tabExist.iOSAudioSource;
      }
      return false; // Keep other types of tabs
    });

    // Now we remove the audio sources that do no longer exist in the settings
    iOSAudioSources.removeWhere((tabElement) {
      BrowserTab? tabExist = settings.browserTabs.tabs.firstWhereOrNull(
        (settingsTab) => settingsTab.id == tabElement.tab.id,
      );
      return tabExist == null || !tabExist.toggled || !tabExist.iOSAudioSource;
    });

    // Check if OBS have to be removed
    if (obsTabViewController != null && !settings.isObsConnected) {
      tabElements.removeWhere((t) => t is ObsTabView);
      obsTabViewController = null;
      await Get.delete<ObsTabViewController>();
    }

    // Check if StreamElements have to be removed
    if (streamelementsViewController != null) {
      tabElements.removeWhere((t) => t is StreamelementsTabView);
      streamelementsViewController = null;
      await Get.delete<StreamelementsViewController>();
    }

    // Check if Twitch have to be removed
    if (twitchTabViewController != null &&
        homeViewController.twitchData.value == null) {
      tabElements.removeWhere((t) => t is TwitchTabView);
      twitchTabViewController = null;
      await Get.delete<TwitchTabViewController>();
    }

    // Check if Kick have to be removed
    if (kickTabViewController != null &&
        homeViewController.kickData.value == null) {
      tabElements.removeWhere((t) => t is KickTabView);
      kickTabViewController = null;
      await Get.delete<KickTabViewController>();
    }

    // Check if Realtime IRL have to be removed
    if (realtimeIrlViewController != null && settings.rtIrlPushKey.isEmpty) {
      tabElements.removeWhere((t) => t is RealtimeIrlTabView);
      realtimeIrlViewController = null;
      await Get.delete<RealtimeIrlViewController>();
    }

    // Check if RTMP have to be removed
    // if (rtmpTabViewController != null) {
    //   tabElements.removeWhere((t) => t is RtmpTabView);
    //   rtmpTabViewController = null;
    //   await Get.delete<RtmpTabViewController>();
    // }
  }

  Future<void> addTabs() async {
    bool isSubscribed = Get.find<StoreService>().isSubscribed();
    Settings settings = settingsService.settings.value;

    // Check if OBS have to be added
    if (obsTabViewController == null && settings.isObsConnected) {
      obsTabViewController = Get.find<ObsTabViewController>();
      tabElements.insert(0, const ObsTabView());
    }

    // Check if Twitch have to be added
    if (twitchTabViewController == null &&
        homeViewController.twitchData.value != null) {
      twitchTabViewController = Get.find<TwitchTabViewController>();
      twitchTabViewController?.setup(
        token: homeViewController.twitchData.value!.accessToken,
        broadcasterId: homeViewController.twitchData.value!.twitchUser.id,
      );
      tabElements.insert(0, const TwitchTabView());
    }

    // Check if Kick have to be added
    if (kickTabViewController == null &&
        homeViewController.kickData.value != null) {
      kickTabViewController = Get.find<KickTabViewController>();
      tabElements.insert(0, const KickTabView());
    }

    // Check if StreamElements have to be added
    if (isSubscribed && streamelementsViewController == null) {
      final box = GetStorage();
      var seCredentialsString = box.read('seCredentials');
      if (seCredentialsString != null) {
        streamelementsViewController = Get.find<StreamelementsViewController>();
        tabElements.insert(0, const StreamelementsTabView());
      }
    }

    // Check if Realtime IRL have to be added
    if (settings.rtIrlPushKey.isNotEmpty && realtimeIrlViewController == null) {
      realtimeIrlViewController = Get.find<RealtimeIrlViewController>();
      tabElements.add(const RealtimeIrlTabView());
    }

    final rtmpListResult = await getRtmpListUseCase();
    rtmpListResult.fold(
      (l) {
        talkerService.talker.error('Failed to get RTMP list');
      },
      (r) {
        // Check if RTMP tab has to be added
        if (rtmpTabViewController == null && r.isNotEmpty) {
          initRtmpTabViewController();
        }
      },
    );

    // Only add the tabs that are toggled
    for (BrowserTab tab in settings.browserTabs.tabs.where((t) => t.toggled)) {
      // Check if the tab already exists
      bool tabExists = tabElements
              .whereType<WebPageView>()
              .any((element) => element.tab.id == tab.id) ||
          iOSAudioSources.any((element) => element.tab.id == tab.id);
      if (tabExists) {
        continue;
      }

      WebPageView page = WebPageView(tab, key: GlobalKey());
      if (!tab.iOSAudioSource) {
        tabElements.add(page);
      } else {
        iOSAudioSources.add(page);
      }
    }
  }

  Future generateTabs() async {
    removeTabs();
    addTabs();
    reorderTabs();

    if (obsTabViewController != null) {
      obsTabViewController?.applySettings();
    }
    if (streamelementsViewController != null) {
      streamelementsViewController?.applySettings();
    }
    if (realtimeIrlViewController != null) {
      realtimeIrlViewController?.applySettings();
    }
    if (rtmpTabViewController != null) {
      rtmpTabViewController?.getRtmpList();
    }

    tabController = TabController(length: tabElements.length, vsync: this);
    if (tabIndex.value > tabElements.length - 1) {
      tabIndex.value = 0;
    }
    tabController.animateTo(tabIndex.value);
  }

  void initRtmpTabViewController() {
    rtmpTabViewController = Get.find<RtmpTabViewController>();
    tabElements.add(const RtmpTabView());
    tabController = TabController(length: tabElements.length, vsync: this);
  }
}
