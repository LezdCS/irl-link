import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/twitch_event_sub_service.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/presentation/controllers/twitch_tab_view_controller.dart';
import 'package:irllink/src/presentation/widgets/poll.dart';
import 'package:irllink/src/presentation/widgets/prediction.dart';
import 'package:irllink/src/presentation/widgets/tabs/dialogs/slow_mode_dialog.dart';
import 'package:irllink/src/presentation/widgets/web_page_view.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TwitchTabView extends GetView<TwitchTabViewController> {
  const TwitchTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.refreshData();
        return Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            left: 20,
            top: 12,
            right: 20,
            bottom: 12,
          ),
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              value: controller
                                  .refreshDataAnimationController.value,
                              strokeWidth: 2,
                              color: Theme.of(context).colorScheme.tertiary,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
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
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        'Status Event Sub:',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Obx(
                        () =>
                            Get.find<TwitchEventSubService>().isConnected.value
                                ? const Icon(
                                    Icons.stream_sharp,
                                    size: 12,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.close,
                                    size: 12,
                                    color: Colors.red,
                                  ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () {
                          Color circleColor = controller
                                  .twitchStreamInfos.value.isOnline!
                              ? Colors.red
                              : Theme.of(context).colorScheme.tertiaryContainer;
                          Color shadowColor =
                              controller.twitchStreamInfos.value.isOnline!
                                  ? Colors.red.shade900.withOpacity(0.5)
                                  : Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer
                                      .withOpacity(0.5);
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
                          controller.twitchStreamInfos.value.isOnline!
                              ? "live".tr
                              : "offline".tr,
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.twitchStreamInfos.value.isOnline!,
                      child: Text(
                        controller.twitchStreamInfos.value.startedAtDuration
                            .toString()
                            .substring(0, 7),
                      ),
                    ),
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
                            controller.twitchStreamInfos.value.viewerCount
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 12, right: 10),
                      child: TextFormField(
                        controller: controller.titleFormController,
                        focusNode: controller.focus,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 7,
                          ),
                          hintText: "Your stream's title",
                          labelText: 'stream_title'.tr,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      fixedSize: const Size(80, 20),
                    ),
                    onPressed: () {
                      controller.setStreamTitle();
                      FocusScope.of(context).unfocus();
                    },
                    child: Text(
                      'change'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 30,
              ),
              Text(
                "shortcuts".tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.only(top: 10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: 4,
                children: [
                  Obx(
                    () => _shortcutButton(
                      context: context,
                      text: 'follower_only'.tr,
                      onTap: () => {
                        controller.toggleFollowerOnly(),
                      },
                      isOn: controller.twitchStreamInfos.value.isFollowerMode!,
                    ),
                  ),
                  Obx(
                    () => _shortcutButton(
                      context: context,
                      text: 'subscriber_only'.tr,
                      onTap: () => {
                        controller.toggleSubOnly(),
                      },
                      isOn:
                          controller.twitchStreamInfos.value.isSubscriberMode!,
                    ),
                  ),
                  Obx(
                    () => _shortcutButton(
                      context: context,
                      text: 'emote_only'.tr,
                      onTap: () => {
                        controller.toggleEmoteOnly(),
                      },
                      isOn: controller.twitchStreamInfos.value.isEmoteMode!,
                    ),
                  ),
                  Obx(
                    () => _shortcutButton(
                      context: context,
                      text: 'slow_mode'.tr,
                      onTap: () => {
                        if (controller.twitchStreamInfos.value.isSlowMode!)
                          {controller.toggleSlowMode(0)}
                        else
                          {Get.dialog(slowModeDialog(context, controller))},
                      },
                      isOn: controller.twitchStreamInfos.value.isSlowMode!,
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 30,
              ),
              _shortcutButton(
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
                                    'https://www.twitch.tv/${controller.homeViewController.twitchData?.twitchUser.login}',
                                backgroundColor: Colors.white,
                                size: 200,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "https://www.twitch.tv/${controller.homeViewController.twitchData?.twitchUser.login}",
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
              const Divider(
                height: 30,
              ),
              Obx(
                () => _shortcutButton(
                  context: context,
                  text: controller.displayTwitchPlayer.value
                      ? "hide_stream".tr
                      : "show_stream".tr,
                  onTap: () => {
                    controller.displayTwitchPlayer.toggle(),
                  },
                  isOn: controller.twitchStreamInfos.value.isSlowMode!,
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.displayTwitchPlayer.value,
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
                            'https://player.twitch.tv/?channel=${controller.homeViewController.twitchData?.twitchUser.login}&parent=www.irllink.com&muted=true',
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 30,
              ),
              Obx(
                () => Get.find<TwitchEventSubService>().isConnected.value
                    ? prediction(
                        context,
                        Get.find<TwitchEventSubService>()
                            .currentPrediction
                            .value,
                      )
                    : Container(),
              ),
              const Divider(
                height: 30,
              ),
              Obx(
                () => Get.find<TwitchEventSubService>().isConnected.value
                    ? poll(
                        context,
                        Get.find<TwitchEventSubService>().currentPoll.value,
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _shortcutButton({
  required BuildContext context,
  required String text,
  required Function onTap,
  required bool isOn,
}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isOn
            ? Theme.of(context).colorScheme.tertiary
            : Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
