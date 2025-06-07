import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irllink/src/presentation/controllers/tabs_controller.dart';
import 'package:irllink/src/presentation/views/tabs/kick_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/obs_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/realtime_irl_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/rtmp_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/streamelements_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/twitch_tab_view.dart';
import 'package:irllink/src/presentation/widgets/web_page_view.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          _tabBar(context),
          _tabs(context),
        ],
      ),
    );
  }

  Widget _tabBar(BuildContext context) {
    return Obx(
      () => TabBar(
        controller: controller.tabController,
        isScrollable: true,
        indicatorWeight: 0.01,
        onTap: (index) {
          controller.tabIndex.value = index;
        },
        tabs: List<Tab>.generate(
          controller.tabElements.length,
          (int index) => Tab(
            child: Text(
              controller.tabElements[index] is ObsTabView
                  ? "OBS"
                  : controller.tabElements[index] is StreamelementsTabView
                      ? "StreamElements"
                      : controller.tabElements[index] is RealtimeIrlTabView
                          ? "RealtimeIRL"
                          : controller.tabElements[index] is TwitchTabView
                              ? "Twitch"
                              : controller.tabElements[index] is KickTabView
                                  ? "Kick"
                                  : controller.tabElements[index] is RtmpTabView
                                      ? "RTMP"
                                      : controller.tabElements[index]
                                              is WebPageView
                                          ? (controller.tabElements[index]
                                                  as WebPageView)
                                              .tab
                                              .title
                                          : "",
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabs(BuildContext context) {
    return Expanded(
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: Obx(
          () => IndexedStack(
            index: controller.tabIndex.value,
            children: controller.tabElements,
          ),
        ),
      ),
    );
  }
}
