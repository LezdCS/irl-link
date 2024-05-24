import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/twitch_tab_view_controller.dart';
import 'package:irllink/src/presentation/widgets/alert_message_view.dart';
import 'package:irllink/src/presentation/widgets/poll.dart';
import 'package:irllink/src/presentation/widgets/prediction.dart';
import 'package:irllink/src/presentation/widgets/tabs/dialogs/slow_mode_dialog.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
        child: Obx(
          () => Container(
            padding: const EdgeInsets.only(
                left: 20.0, top: 12.0, right: 20.0, bottom: 12.0),
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: controller.homeViewController.twitchData == null,
                  child: const AlertMessageView(
                    color: Color(0xFF196DEE),
                    message: "DEMO",
                    isProgress: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: LinearPercentIndicator(
                    animation: true,
                    animateFromLastPercent: true,
                    barRadius: const Radius.circular(8),
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    lineHeight: 3.0,
                    percent: controller.myDuration.value.inSeconds / 15,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    progressColor: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: controller.twitchStreamInfos.value.isOnline!
                              ? Colors.red
                              : Theme.of(context).colorScheme.tertiaryContainer,
                        ),
                        const Padding(padding: EdgeInsets.only(right: 6.0)),
                        Text(
                          controller.twitchStreamInfos.value.isOnline!
                              ? "live".tr
                              : "offline".tr,
                          style: TextStyle(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyLarge!
                                .color,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: controller.twitchStreamInfos.value.isOnline!,
                      child: Text(controller
                          .twitchStreamInfos.value.startedAtDuration
                          .toString()
                          .substring(0, 7)),
                    ),
                    Visibility(
                      visible: controller.homeViewController.settings.value
                          .generalSettings!.displayViewerCount,
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
                            style: TextStyle(
                              color: Theme.of(Get.context!)
                                  .textTheme
                                  .bodyLarge!
                                  .color,
                            ),
                          ),
                        ],
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
                          style: Theme.of(Get.context!).textTheme.bodyLarge,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 7),
                            hintText: 'Your stream\'s title',
                            labelText: 'stream_title'.tr,
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 11),
                        backgroundColor: Colors.deepPurpleAccent,
                        fixedSize: const Size(50, 20),
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
                Divider(
                  height: 40,
                  thickness: 4,
                  indent: 0,
                  endIndent: 0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                Text(
                  "shortcuts".tr,
                  style: TextStyle(
                    color: Theme.of(Get.context!).textTheme.bodyLarge!.color,
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
                    _shortcutButton(
                      context: context,
                      text: 'follower_only'.tr,
                      onTap: () => {
                        controller.toggleFollowerOnly(),
                      },
                      isOn: controller.twitchStreamInfos.value.isFollowerMode!,
                    ),
                    _shortcutButton(
                      context: context,
                      text: 'subscriber_only'.tr,
                      onTap: () => {
                        controller.toggleSubOnly(),
                      },
                      isOn:
                          controller.twitchStreamInfos.value.isSubscriberMode!,
                    ),
                    _shortcutButton(
                      context: context,
                      text: 'emote_only'.tr,
                      onTap: () => {
                        controller.toggleEmoteOnly(),
                      },
                      isOn: controller.twitchStreamInfos.value.isEmoteMode!,
                    ),
                    _shortcutButton(
                      context: context,
                      text: 'slow_mode'.tr,
                      onTap: () => {
                        if (controller.twitchStreamInfos.value.isSlowMode!)
                          {controller.toggleSlowMode(0)}
                        else
                          {Get.dialog(slowModeDialog(context, controller))}
                      },
                      isOn: controller.twitchStreamInfos.value.isSlowMode!,
                    ),
                  ],
                ),
                Divider(
                  height: 40,
                  thickness: 4,
                  indent: 0,
                  endIndent: 0,
                  color: Theme.of(context).colorScheme.secondary,
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
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Channel QR Code",
                                  style: TextStyle(
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
                                  version: QrVersions.auto,
                                  backgroundColor: Colors.white,
                                  size: 200.0,
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
                  text: "Channel QR Code",
                  context: context,
                  isOn: false,
                ),
                Divider(
                  height: 40,
                  thickness: 4,
                  indent: 0,
                  endIndent: 0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                Get.find<TwitchTabViewController>().twitchEventSub != null
                    ? prediction(
                        context,
                        controller,
                        controller.twitchEventSub!.currentPrediction.value,
                      )
                    : Container(),
                Divider(
                  height: 40,
                  thickness: 4,
                  indent: 0,
                  endIndent: 0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                controller.twitchEventSub != null
                    ? poll(
                        context,
                        controller,
                        controller.twitchEventSub!.currentPoll.value,
                      )
                    : Container(),
              ],
            ),
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
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
