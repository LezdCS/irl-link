import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_prediction.dart';
import 'package:irllink/src/presentation/controllers/chats_controller.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/kick_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/twitch_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs_controller.dart';
import 'package:irllink/src/presentation/views/chats_view.dart';
import 'package:irllink/src/presentation/views/dashboard.dart';
import 'package:irllink/src/presentation/views/tabs_view.dart';
import 'package:irllink/src/presentation/widgets/chats/select_channel_dialog.dart';
import 'package:irllink/src/presentation/widgets/emote_picker_view.dart';
import 'package:irllink/src/presentation/widgets/pinned_messages_sheet.dart';
import 'package:irllink/src/presentation/widgets/poll.dart';
import 'package:irllink/src/presentation/widgets/prediction.dart';
import 'package:kick_chat/kick_chat.dart';
import 'package:split_view/split_view.dart';
import 'package:twitch_chat/twitch_chat.dart';
import 'package:upgrader/upgrader.dart';

class HomeView extends GetView<HomeViewController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final storeService = Get.find<StoreService>();

    return UpgradeAlert(
      upgrader: Upgrader(
        minAppVersion: controller.minimumVersion.value,
        debugDisplayAlways: kDebugMode,
      ),
      child: PopScope(
        child: AnnotatedRegion(
          value: SystemUiOverlayStyle(
            systemNavigationBarColor: Theme.of(context).colorScheme.surface,
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Obx(
              () => Container(
                constraints: const BoxConstraints.expand(),
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.surface,
                ),
                child: SafeArea(
                  child: Stack(
                    children: [
                      Stack(
                        children: List<Widget>.generate(
                          Get.find<TabsController>().iOSAudioSources.length,
                          (int index) =>
                              Get.find<TabsController>().iOSAudioSources[index],
                        ),
                      ),
                      Listener(
                        onPointerUp: (_) => {
                          controller.displayDashboard.value = false,
                        },
                        child: SplitView(
                          controller: controller.splitViewController,
                          gripColor: context.theme.colorScheme.secondary,
                          gripColorActive: context.theme.colorScheme.secondary,
                          gripSize: 8,
                          viewMode: context.isPortrait
                              ? SplitViewMode.Vertical
                              : SplitViewMode.Horizontal,
                          indicator: SplitIndicator(
                            viewMode: context.isPortrait
                                ? SplitViewMode.Vertical
                                : SplitViewMode.Horizontal,
                            color: const Color(0xFF464444),
                          ),
                          activeIndicator: SplitIndicator(
                            color: const Color(0xFF464444),
                            viewMode: context.isPortrait
                                ? SplitViewMode.Vertical
                                : SplitViewMode.Horizontal,
                            isActive: true,
                          ),
                          onWeightChanged: controller.onSplitResized,
                          children: [
                            const TabsView(),
                            _bottom(context, height, width),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: controller.displayDashboard.value,
                        child: const Dashboard(),
                      ),
                      Visibility(
                        visible: storeService.purchasePending.value,
                        child: CircularProgressIndicator(
                          color: context.theme.colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottom(BuildContext context, double height, double width) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        children: [
          Listener(
            onPointerUp: (_) => {
              controller.isPickingEmote.value = false,
            },
            child: Get.find<ChatsController>().chatsViews.isNotEmpty
                ? const ChatsView()
                : const Text('No chats'),
          ),
          Visibility(
            visible: controller.isPickingEmote.value,
            child: const Positioned(
              bottom: 50,
              top: 50,
              left: 10,
              right: 150,
              child: EmotePickerView(),
            ),
          ),
          Positioned(
            bottom: height * 0.07,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              offset: controller.showPinnedMessages.value
                  ? Offset.zero
                  : const Offset(0, 1),
              duration: const Duration(milliseconds: 200),
              child: Visibility(
                visible: controller.showPinnedMessages.value,
                child: PinnedMessagesSheet(messages: controller.pinnedMessages),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _bottomNavBar(height, width, context),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavBar(double height, double width, BuildContext context) {
    Settings settings = Get.find<SettingsService>().settings.value;

    return Container(
      padding: const EdgeInsets.only(left: 10),
      height: height * 0.06,
      child: Row(
        children: [
          Visibility(
            visible: Get.find<HomeViewController>().twitchData.value != null ||
                Get.find<HomeViewController>().kickData.value != null,
            child: Expanded(
              flex: 5,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 45, 2, 53),
                      Color.fromARGB(255, 81, 16, 93),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                padding:
                    const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => controller.getEmotes(),
                      child: const Image(
                        image: AssetImage("lib/assets/twitchSmileEmoji.png"),
                        width: 30,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller.chatInputController,
                        onTap: () {
                          Get.find<ChatsController>().selectedMessage.value =
                              null;
                          controller.isPickingEmote.value = false;
                        },
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: settings.generalSettings.displayViewerCount
                              ? "viewers_number".trParams({
                                  "number": ((Get.isRegistered<
                                                  TwitchTabViewController>()
                                              ? Get.find<TwitchTabViewController>()
                                                      .twitchStreamInfos
                                                      .value
                                                      .viewerCount ??
                                                  0
                                              : 0) +
                                          (Get.isRegistered<
                                                  KickTabViewController>()
                                              ? Get.find<KickTabViewController>()
                                                      .kickChannel
                                                      .value
                                                      ?.stream
                                                      .viewerCount ??
                                                  0
                                              : 0))
                                      .toString(),
                                })
                              : 'send_message'.tr,
                          hintStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                          isDense: true,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.only(left: 5),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.sendChatMessage(
                          controller.chatInputController.text,
                        );
                      },
                      child: Icon(
                        Icons.send,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: 21,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (controller.twitchEventSubService != null)
            Obx(
              () => Visibility(
                visible: controller
                        .twitchEventSubService!.currentPoll.value.status !=
                    PollStatus.empty,
                child: Expanded(
                  child: InkWell(
                    onTap: () async {
                      Get.dialog(
                        AlertDialog(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          surfaceTintColor:
                              Theme.of(context).colorScheme.surface,
                          content: Container(
                            width: width,
                            color: Theme.of(context).colorScheme.surface,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(
                                  () => poll(
                                    context,
                                    controller.twitchEventSubService!
                                        .currentPoll.value,
                                    controller.twitchEventSubService,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.poll_outlined,
                      color: Theme.of(context).primaryIconTheme.color,
                      size: 22,
                    ),
                  ),
                ),
              ),
            )
          else
            Container(),
          if (controller.twitchEventSubService != null)
            Obx(
              () => Visibility(
                visible: controller.twitchEventSubService!.currentPrediction
                        .value.status !=
                    PredictionStatus.empty,
                child: Expanded(
                  child: InkWell(
                    onTap: () async {
                      Get.dialog(
                        AlertDialog(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          surfaceTintColor:
                              Theme.of(context).colorScheme.surface,
                          content: Container(
                            width: width,
                            color: Theme.of(context).colorScheme.surface,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(
                                  () => prediction(
                                    context,
                                    controller.twitchEventSubService!
                                        .currentPrediction.value,
                                    controller.twitchEventSubService!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: SvgPicture.asset(
                      './lib/assets/twitch/prediction.svg',
                      semanticsLabel: 'prediction icon',
                      width: 22,
                      height: 22,
                    ),
                  ),
                ),
              ),
            )
          else
            Container(),
          Visibility(
            visible: controller.pinnedMessages.isNotEmpty,
            child: Expanded(
              child: InkWell(
                onTap: () {
                  controller.showPinnedMessages.toggle();
                },
                child: Icon(
                  Icons.push_pin,
                  color: Theme.of(context).primaryIconTheme.color,
                  size: 22,
                ),
              ),
            ),
          ),
          Visibility(
            visible: settings.dashboardSettings.activated,
            child: Expanded(
              child: InkWell(
                onTap: () async {
                  controller.displayDashboard.value =
                      !controller.displayDashboard.value;
                },
                child: Icon(
                  Icons.dashboard_rounded,
                  color: Theme.of(context).primaryIconTheme.color,
                  size: 22,
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () async {
                await Get.toNamed(
                  Routes.settings,
                );
                Get.find<ChatsController>().generateChats();
                Get.find<TabsController>().generateTabs();
              },
              child: Icon(
                Icons.settings,
                color: Theme.of(context).primaryIconTheme.color,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void selectChatToSend(
  BuildContext context,
  HomeViewController controller,
  List<TwitchChat> twitchChats,
  List<KickChat> kickChats,
  String message,
) {
  Get.defaultDialog(
    title: 'Select a chat to send',
    titleStyle: const TextStyle(color: Colors.white),
    backgroundColor: const Color(0xFF282828),
    buttonColor: const Color(0xFF9147ff),
    cancelTextColor: const Color(0xFF9147ff),
    textCancel: "cancel".tr,
    radius: 10,
    onCancel: () {
      Get.back();
    },
    content: SelectChannelDialog(
      twitchChats: twitchChats,
      kickChats: kickChats,
      controller: controller,
      message: message,
    ),
  );
}
