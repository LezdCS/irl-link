import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irllink/src/presentation/controllers/tabs_controller.dart';

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
        controller: controller.tabController.value,
        isScrollable: true,
        indicatorWeight: 0.01,
        onTap: (index) => controller.setTabIndex(index),
        tabs: List<Tab>.generate(
          controller.tabElements.length,
          (int index) => Tab(
            child: Text(
              controller.getTabTitle(controller.tabElements[index]),
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
            index: controller.tabController.value.index,
            children: controller.tabElements,
          ),
        ),
      ),
    );
  }
}
