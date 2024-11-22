import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';
import 'package:irllink/src/presentation/widgets/stream_elements/se_activities_list.dart';
import 'package:irllink/src/presentation/widgets/stream_elements/se_overlays.dart';
import 'package:irllink/src/presentation/widgets/stream_elements/se_song_requests.dart';

class StreamelementsTabView extends GetView<StreamelementsViewController> {
  const StreamelementsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> tabsTiles = [
      const Text("Activities"),
      const Text("Song Requests"),
      const Text("Overlays"),
    ];

    List<Widget> tabs = [
      const SeActivitiesList(),
      const SeSongRequests(),
      const SeOverlays(),
    ];

    return Obx(
      () => controller.isSocketConnected.value
          ? Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: TabBar(
                    controller: controller.tabController,
                    isScrollable: true,
                    indicator: const BoxDecoration(),
                    tabAlignment: TabAlignment.center,
                    tabs: tabsTiles,
                  ),
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.surface,
                    ),
                    child: TabBarView(
                      controller: controller.tabController,
                      children: tabs,
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: Text("Not connected to StreamElements"),
            ),
    );
  }
}
