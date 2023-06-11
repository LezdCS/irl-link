import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';

import '../stream_elements/se_activities_list.dart';

class StreamelementsTabView extends GetView<StreamelementsViewController> {
  const StreamelementsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isSocketConnected.value
          ? Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: TabBar(
                    controller: controller.tabController,
                    isScrollable: true,
                    labelColor: Theme.of(context).colorScheme.tertiary,
                    unselectedLabelColor:
                        context.theme.textTheme.bodyLarge!.color,
                    indicatorColor: Theme.of(context).colorScheme.tertiary,
                    indicatorWeight: 0.000001,
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Text("Activities"),
                      // Text("Song Requests"),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.background,
                    ),
                    child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        SeActivitiesList(
                          controller: controller,
                        ),
                        // SeSongRequests(
                        //   controller: controller,
                        // ),
                      ],
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
