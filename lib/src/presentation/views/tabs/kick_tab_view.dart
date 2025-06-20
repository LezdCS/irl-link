import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/kick/kick_category.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/kick_tab_view_controller.dart';
import 'package:irllink/src/presentation/views/tabs/twitch_tab_view.dart';
import 'package:irllink/src/presentation/widgets/web_page_view.dart';
import 'package:qr_flutter/qr_flutter.dart';

class KickTabView extends GetView<KickTabViewController> {
  const KickTabView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.kickChannel.value == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Wrap(
                children: [
                  SizedBox(
                    width: 14,
                    height: 14,
                    child: AnimatedBuilder(
                      animation: controller.refreshDataAnimationController,
                      builder: (context, child) {
                        return CircularProgressIndicator(
                          value:
                              controller.refreshDataAnimationController.value,
                          strokeWidth: 2,
                          color: Theme.of(context).colorScheme.tertiary,
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiaryContainer,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "refresh_data".tr,
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () {
                          Color circleColor = controller
                                  .kickChannel.value!.stream.isLive
                              ? Colors.red
                              : Theme.of(context).colorScheme.tertiaryContainer;
                          Color shadowColor =
                              controller.kickChannel.value!.stream.isLive
                                  ? Colors.red.shade900.withValues(alpha: 0.5)
                                  : Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer
                                      .withValues(alpha: 0.5);
                          return AnimatedBuilder(
                            animation: controller.circleShadowAnimation,
                            builder: (context, child) {
                              return Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: circleColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: shadowColor,
                                      spreadRadius: controller
                                              .circleShadowAnimation.value *
                                          0.1,
                                      blurRadius: controller
                                              .circleShadowAnimation.value *
                                          0.4,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const Padding(padding: EdgeInsets.only(right: 6)),
                      Obx(
                        () => Text(
                          controller.kickChannel.value!.stream.isLive
                              ? "live".tr
                              : "offline".tr,
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Visibility(
                      visible: Get.find<SettingsService>()
                          .settings
                          .value
                          .generalSettings
                          .displayViewerCount,
                      child: Row(
                        children: [
                          const Icon(Icons.person_outline, color: Colors.red),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            controller.kickChannel.value!.stream.viewerCount
                                .toString(),
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            "viewers".tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Column(
                    spacing: 10,
                    children: [
                      Obx(
                        () => controller.kickCategories.isEmpty
                            ? const SizedBox.shrink()
                            : Autocomplete<KickCategory>(
                                optionsBuilder:
                                    (TextEditingValue textEditingValue) {
                                  if (textEditingValue.text.isEmpty) {
                                    return controller
                                            .kickChannel.value!.stream.isLive
                                        ? controller.kickCategories
                                        : [];
                                  }
                                  controller.onCategorySearchChanged(
                                    textEditingValue.text,
                                  );
                                  return controller.kickCategories.where(
                                    (category) => category.name
                                        .toLowerCase()
                                        .contains(
                                          textEditingValue.text.toLowerCase(),
                                        ),
                                  );
                                },
                                displayStringForOption:
                                    (KickCategory category) => category.name,
                                onSelected: (KickCategory category) {
                                  controller.selectedCategoryId.value =
                                      category.id;
                                },
                                fieldViewBuilder: (
                                  BuildContext context,
                                  TextEditingController fieldController,
                                  FocusNode fieldFocusNode,
                                  VoidCallback onFieldSubmitted,
                                ) {
                                  return TextFormField(
                                    controller: fieldController,
                                    focusNode: fieldFocusNode,
                                    decoration: const InputDecoration(
                                      labelText: 'Search and Select Category',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.search),
                                    ),
                                  );
                                },
                              ),
                      ),
                      Obx(
                        () => TextFormField(
                          controller: controller.titleFormController,
                          focusNode: controller.focus,
                          readOnly:
                              !controller.kickChannel.value!.stream.isLive,
                          decoration: const InputDecoration(
                            labelText: 'Stream Title',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Obx(
                        () => shortcutButton(
                          context: context,
                          text: "Update",
                          onTap: () => {
                            if (controller.kickChannel.value!.stream.isLive)
                              {
                                controller.updateKickChannel(),
                              },
                          },
                          isOn: controller.kickChannel.value!.stream.isLive,
                        ),
                      ),
                    ],
                  ),
                  if (!controller.kickChannel.value!.stream.isLive)
                    Positioned.fill(
                      child: ColoredBox(
                        color: Colors.grey[900]!.withValues(alpha: 0.7),
                        child: const Center(
                          child: Text(
                            "You need to be live to modify your stream details",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const Divider(
                height: 10,
              ),
              shortcutButton(
                context: context,
                text: "Start streaming on Kick",
                onTap: () => {
                  controller.startStreaming(),
                },
                isOn: false,
              ),
              const Divider(
                height: 10,
              ),
              Obx(
                () => shortcutButton(
                  context: context,
                  text: controller.displayKickPlayer.value
                      ? "hide_stream".tr
                      : "show_stream".tr,
                  onTap: () => {
                    controller.displayKickPlayer.toggle(),
                  },
                  isOn: false,
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.displayKickPlayer.value,
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: WebPageView(
                      BrowserTab(
                        iOSAudioSource: false,
                        id: '1',
                        title: '',
                        toggled: true,
                        url:
                            'https://player.kick.com/${Get.find<HomeViewController>().kickData.value?.kickUser.name}',
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 10,
              ),
              shortcutButton(
                onTap: () {
                  Get.dialog(
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "channel_qr_code".tr,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              QrImageView(
                                data:
                                    'https://www.kick.com/${Get.find<HomeViewController>().kickData.value?.kickUser.name}',
                                backgroundColor: Colors.white,
                                size: 200,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "https://www.kick.com/${Get.find<HomeViewController>().kickData.value?.kickUser.name}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                text: "channel_qr_code".tr,
                context: context,
                isOn: false,
              ),
            ],
          ),
        ),
      );
    });
  }
}
