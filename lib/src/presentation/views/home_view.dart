import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_prediction.dart';
import 'package:irllink/src/presentation/controllers/chat_view_controller.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/presentation/controllers/twitch_tab_view_controller.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_view.dart';
import 'package:irllink/src/presentation/widgets/chats/select_channel_dialog.dart';
import 'package:irllink/src/presentation/widgets/dashboard.dart';
import 'package:irllink/src/presentation/widgets/emote_picker_view.dart';
import 'package:irllink/src/presentation/widgets/hype_train.dart';
import 'package:irllink/src/presentation/widgets/poll.dart';
import 'package:irllink/src/presentation/widgets/prediction.dart';
import 'package:irllink/src/presentation/widgets/tabs/obs_tab_view.dart';
import 'package:irllink/src/presentation/widgets/tabs/realtime_irl_tab_view.dart';
import 'package:irllink/src/presentation/widgets/tabs/streamelements_tab_view.dart';
import 'package:irllink/src/presentation/widgets/tabs/twitch_tab_view.dart';
import 'package:irllink/src/presentation/widgets/web_page_view.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:split_view/split_view.dart';
import 'package:twitch_chat/twitch_chat.dart';

class HomeView extends GetView<HomeViewController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return PopScope(
      onPopInvokedWithResult: (bool invoked, dynamic d) async {
        if (invoked) {
          MoveToBackground.moveTaskToBack();
        }
      },
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context).colorScheme.surface,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Obx(
            () => Listener(
              onPointerUp: (_) => {
                FocusScope.of(context).unfocus(),
              },
              child: Container(
                constraints: const BoxConstraints.expand(),
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.surface,
                ),
                child: SafeArea(
                  child: Stack(
                    children: [
                      Stack(
                        children: List<Widget>.generate(
                          controller.iOSAudioSources.length,
                          (int index) => controller.iOSAudioSources[index],
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
                            controller.tabElements.isNotEmpty
                                ? _top(context, height, width)
                                : const Text(
                                    "No tabs",
                                    textAlign: TextAlign.center,
                                  ),
                            _bottom(context, height, width),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: controller.displayDashboard.value,
                        child: const Dashboard(),
                      ),
                      Visibility(
                        visible: Get.find<StoreService>().purchasePending.value,
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

  Widget _top(BuildContext context, double height, double width) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          _tabBar(context, height, width),
          _tabs(context),
        ],
      ),
    );
  }

  Widget _bottom(BuildContext context, double height, double width) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        children: [
          Listener(
            onPointerUp: (_) => {
              controller.isPickingEmote.value = false,
            },
            child: controller.chatsViews.isNotEmpty
                ? Column(
                    children: [
                      Visibility(
                        visible: Get.find<TwitchTabViewController>()
                                .twitchEventSub !=
                            null,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 4, bottom: 0),
                          child: hypeTrain(
                              context, Get.find<TwitchTabViewController>()),
                        ),
                      ),
                      Visibility(
                        visible: controller.chatsViews.length > 1,
                        child: _tabBarChats(context),
                      ),
                      _chats(context),
                    ],
                  )
                : Container(),
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
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: _bottomNavBar(height, width, context),
          ),
        ],
      ),
    );
  }

  Widget _tabBar(BuildContext context, double height, double width) {
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
                              : controller.tabElements[index] is WebPageView
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

  Widget _bottomNavBar(double height, double width, BuildContext context) {
    Settings settings = Get.find<SettingsService>().settings.value;

    return Container(
      padding: const EdgeInsets.only(left: 10),
      height: height * 0.06,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SvgPicture.asset(
                  './lib/assets/chatinput.svg',
                  semanticsLabel: 'chat input',
                  fit: BoxFit.fitWidth,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
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
                          onSubmitted: (String value) {
                            if (controller.selectedChatGroup.value == null) {
                              return;
                            }
                            ChatViewController chatViewController =
                                Get.find<ChatViewController>(
                                    tag:
                                        controller.selectedChatGroup.value?.id);
                            List<TwitchChat> twitchChats = [];
                            twitchChats.addAll(
                                chatViewController.twitchChats.toList());
                            if (twitchChats.length == 1) {
                              controller.sendChatMessage(
                                  value, twitchChats.first.channel);
                              controller.chatInputController.text = '';
                              FocusScope.of(context).unfocus();
                            } else {
                              selectChatToSend(
                                context,
                                controller,
                                twitchChats,
                                value,
                              );
                            }
                          },
                          onTap: () {
                            controller.selectedMessage.value = null;
                            controller.isPickingEmote.value = false;
                          },
                          textInputAction: TextInputAction.send,
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: settings
                                    .generalSettings!.displayViewerCount
                                ? '${Get.find<TwitchTabViewController>().twitchStreamInfos.value.viewerCount} viewers'
                                : 'send_message'.tr,
                            hintStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color!,
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
                          if (controller.selectedChatGroup.value == null) {
                            return;
                          }
                          ChatViewController chatViewController =
                              Get.find<ChatViewController>(
                                  tag: controller.selectedChatGroup.value?.id);
                          List<TwitchChat> twitchChats = [];
                          twitchChats
                              .addAll(chatViewController.twitchChats.toList());
                          if (twitchChats.length == 1) {
                            controller.sendChatMessage(
                                controller.chatInputController.text,
                                twitchChats.first.channel);
                            controller.chatInputController.text = '';
                            FocusScope.of(context).unfocus();
                          } else {
                            selectChatToSend(
                              context,
                              controller,
                              twitchChats,
                              controller.chatInputController.text,
                            );
                          }
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
              ],
            ),
          ),
          Get.find<TwitchTabViewController>().twitchEventSub != null
              ? Obx(
                  () => Visibility(
                    visible: Get.find<TwitchTabViewController>()
                            .twitchEventSub!
                            .currentPoll
                            .value
                            .status !=
                        PollStatus.empty,
                    child: Expanded(
                      flex: 1,
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
                                        Get.find<TwitchTabViewController>(),
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
              : Container(),
          Get.find<TwitchTabViewController>().twitchEventSub != null
              ? Obx(
                  () => Visibility(
                    visible: Get.find<TwitchTabViewController>()
                            .twitchEventSub!
                            .currentPrediction
                            .value
                            .status !=
                        PredictionStatus.empty,
                    child: Expanded(
                      flex: 1,
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
                                        Get.find<TwitchTabViewController>(),
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
              : Container(),
          Visibility(
            visible: settings.dashboardSettings!.activated,
            child: Expanded(
              flex: 1,
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
            flex: 1,
            child: InkWell(
              onTap: () async {
                await Get.toNamed(
                  Routes.settings,
                );
                controller.applySettings();
                controller.obsTabViewController?.applySettings();
                controller.streamelementsViewController.value?.applySettings();
                controller.realtimeIrlViewController?.applySettings();
                if (controller.selectedChatIndex != null) {
                  controller.chatTabsController
                      .animateTo(controller.selectedChatIndex!);
                }
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

  Widget _tabs(BuildContext context) {
    return Expanded(
      child: Container(
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

  Widget _tabBarChats(BuildContext context) {
    Color? getPlatformColor(Platform platform) {
      switch (platform) {
        case Platform.twitch:
          return Colors.deepPurpleAccent[200];
        case Platform.kick:
          return const Color.fromARGB(255, 0, 231, 1);
        case Platform.youtube:
          return const Color.fromARGB(255, 255, 0, 0);
        default:
          return Colors.grey;
      }
    }

    return Obx(() {
      int tabsLength = controller.chatsViews.length;

      return TabBar(
        controller: controller.chatTabsController,
        isScrollable: true,
        onTap: (int i) {
          if (Get.isRegistered<ChatViewController>(
              tag: controller.chatsViews[i].chatGroup.id)) {
            ChatViewController c = Get.find<ChatViewController>(
              tag: controller.chatsViews[i].chatGroup.id,
            );
            c.scrollToBottom();
            controller.selectedChatGroup.value = c.chatGroup;
          }
          controller.selectedMessage.value = null;
          controller.selectedChatIndex = i;
        },
        tabs: List<Tab>.generate(
          tabsLength,
          (int index) {
            List<Channel> channels =
                controller.chatsViews[index].chatGroup.channels;
            return Tab(
              height: 30,
              child: Text.rich(
                TextSpan(
                  children: List<TextSpan>.generate(
                    channels.length,
                    (int i) => TextSpan(
                      children: [
                        TextSpan(
                          text: i == (channels.length - 1) ? '' : ', ',
                          style: TextStyle(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyLarge!
                                .color,
                          ),
                        ),
                      ],
                      text: channels[i].channel,
                      style: TextStyle(
                        color: getPlatformColor(channels[i].platform),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _chats(BuildContext context) {
    return Expanded(
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.chatTabsController,
          children: List<Widget>.generate(
            controller.chatsViews.length,
            (int index) => KeepAlive(
              chat: controller.chatsViews[index],
              key: ValueKey(controller.chatsViews[index]),
            ),
          ),
        ),
      ),
    );
  }
}

void selectChatToSend(
  BuildContext context,
  HomeViewController controller,
  List<TwitchChat> twitchChats,
  String message,
) {
  Get.defaultDialog(
    title: 'Select a chat to send',
    titleStyle: const TextStyle(color: Colors.white),
    backgroundColor: const Color(0xFF282828),
    buttonColor: const Color(0xFF9147ff),
    cancelTextColor: const Color(0xFF9147ff),
    textCancel: "Back",
    radius: 10,
    onCancel: () {
      Get.back();
    },
    content: SelectChannelDialog(
      twitchChats: twitchChats,
      controller: controller,
      message: message,
    ),
  );
}

class KeepAlive extends StatefulWidget {
  const KeepAlive({super.key, required this.chat});

  final ChatView chat;

  @override
  State<KeepAlive> createState() => _KeepAlive();
}

class _KeepAlive extends State<KeepAlive> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.chat;
  }
}
