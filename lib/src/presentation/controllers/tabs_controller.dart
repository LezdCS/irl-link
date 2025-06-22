import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/utils/list_move.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/domain/usecases/kick/get_kick_local_usecase.dart';
import 'package:irllink/src/domain/usecases/rtmp/get_rtmp_list_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/get_browser_tabs_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_local_credentials_usecase.dart';
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
    required this.getLocalCredentialsUseCase,
    required this.getBrowserTabsUseCase,
  });

  final SettingsService settingsService;
  final TalkerService talkerService;
  final GetRtmpListUseCase getRtmpListUseCase;
  final GetKickLocalUseCase getKickLocalUseCase;
  final GetTwitchLocalUseCase getTwitchLocalUseCase;
  final HomeViewController homeViewController;
  final StreamElementsGetLocalCredentialsUseCase getLocalCredentialsUseCase;
  final GetBrowserTabsUsecase getBrowserTabsUseCase;

  late Rx<TabController> tabController;
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
    tabController = TabController(length: 0, vsync: this).obs;

    // Listen to tabElements changes and update tabController accordingly
    tabElements.listen((list) {
      _updateTabController();
    });

    generateTabs();
  }

  void _updateTabController() {
    // Dispose old TabController to prevent memory leak
    tabController.value.dispose();

    tabController.value =
        TabController(length: tabElements.length, vsync: this);
    if (tabController.value.index > tabElements.length - 1) {
      tabController.value.animateTo(0);
    }
  }

  void setTabIndex(int index) {
    if (index >= 0 && index < tabElements.length) {
      tabController.value.animateTo(index);
      tabController.refresh();
    }
  }

  void reorderTabs(List<BrowserTab> browserTabs) {
    List<BrowserTab> tabs =
        browserTabs.where((t) => t.toggled && !t.iOSAudioSource).toList();
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

  Future<void> removeTabs(List<BrowserTab> browserTabs) async {
    // Check if WebTabs have to be removed
    tabElements.removeWhere((tabElement) {
      if (tabElement is WebPageView) {
        BrowserTab? tabExist = browserTabs.firstWhereOrNull(
          (settingsTab) => settingsTab.id == tabElement.tab.id,
        );
        return tabExist == null || !tabExist.toggled || tabExist.iOSAudioSource;
      }
      return false; // Keep other types of tabs
    });

    // Now we remove the audio sources that do no longer exist in the settings
    iOSAudioSources.removeWhere((tabElement) {
      BrowserTab? tabExist = browserTabs.firstWhereOrNull(
        (settingsTab) => settingsTab.id == tabElement.tab.id,
      );
      return tabExist == null || !tabExist.toggled || !tabExist.iOSAudioSource;
    });

    // Check if OBS have to be removed
    if (obsTabViewController != null &&
        !settingsService.settings.value.isObsConnected) {
      tabElements.removeWhere((t) => t is ObsTabView);
      obsTabViewController = null;
      await Get.delete<ObsTabViewController>();
    }

    // Check if StreamElements have to be removed
    if (streamelementsViewController != null) {
      final seCredentials = await getLocalCredentialsUseCase();
      seCredentials.fold(
        (l) {
          tabElements.removeWhere((t) => t is StreamelementsTabView);
          streamelementsViewController = null;
          Get.delete<StreamelementsViewController>();
        },
        (r) {
          talkerService.talker.logCustom(
            StreamElementsLog(
              'StreamElements credentials found, no need to remove tab.',
            ),
          );
        },
      );
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
    if (realtimeIrlViewController != null &&
        settingsService.settings.value.rtIrlPushKey.isEmpty) {
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

  Future<void> addTabs(List<BrowserTab> browserTabs) async {
    bool isSubscribed = Get.find<StoreService>().isSubscribed();

    // Check if OBS have to be added
    if (obsTabViewController == null &&
        settingsService.settings.value.isObsConnected) {
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
      final seCredentials = await getLocalCredentialsUseCase();
      seCredentials.fold(
        (l) {
          talkerService.talker
              .error('Failed to get StreamElements credentials');
        },
        (r) {
          talkerService.talker.info('StreamElements credentials found');
          streamelementsViewController =
              Get.find<StreamelementsViewController>();
          tabElements.insert(0, const StreamelementsTabView());
        },
      );
    }

    // Check if Realtime IRL have to be added
    if (settingsService.settings.value.rtIrlPushKey.isNotEmpty &&
        realtimeIrlViewController == null) {
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
    for (BrowserTab tab in browserTabs.where((t) => t.toggled)) {
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
    final browserTabsResult = await getBrowserTabsUseCase(params: null);
    List<BrowserTab> browserTabs = [];
    browserTabsResult.fold(
      (l) {
        talkerService.talker.error('Failed to get browser tabs');
      },
      (r) {
        browserTabs = r;
      },
    );

    await removeTabs(browserTabs);
    await addTabs(browserTabs);
    reorderTabs(browserTabs);

    if (obsTabViewController != null) {
      obsTabViewController?.applySettings();
    }
    if (realtimeIrlViewController != null) {
      realtimeIrlViewController?.applySettings();
    }
    if (rtmpTabViewController != null) {
      rtmpTabViewController?.getRtmpList();
    }
  }

  void initRtmpTabViewController() {
    if (rtmpTabViewController == null) {
      rtmpTabViewController = Get.find<RtmpTabViewController>();
      tabElements.add(const RtmpTabView());
    }
  }

  String getTabTitle(Widget tabElement) {
    if (tabElement is ObsTabView) {
      return "OBS";
    }
    if (tabElement is StreamelementsTabView) {
      return "StreamElements";
    }
    if (tabElement is RealtimeIrlTabView) {
      return "RealtimeIRL";
    }
    if (tabElement is TwitchTabView) {
      return "Twitch";
    }
    if (tabElement is KickTabView) {
      return "Kick";
    }
    if (tabElement is RtmpTabView) {
      return "RTMP";
    }
    if (tabElement is WebPageView) {
      return tabElement.tab.title;
    }
    return "";
  }

  @override
  void dispose() {
    tabController.value.dispose();
    super.dispose();
  }
}
