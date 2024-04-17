import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_prediction.dart';
import 'package:irllink/src/presentation/controllers/chat_view_controller.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/controllers/store_controller.dart';
import 'package:irllink/src/presentation/controllers/twitch_tab_view_controller.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_view.dart';
import 'package:irllink/src/presentation/widgets/chats/select_channel_dialog.dart';
import 'package:irllink/src/presentation/widgets/dashboard.dart';
import 'package:irllink/src/presentation/widgets/emote_picker_view.dart';
import 'package:irllink/src/presentation/widgets/hype_train.dart';
import 'package:irllink/src/presentation/widgets/poll.dart';
import 'package:irllink/src/presentation/widgets/prediction.dart';
import 'package:irllink/src/presentation/widgets/tabs/obs_tab_view.dart';
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
      onPopInvoked: (bool invoked) async {
        if (invoked) {
          MoveToBackground.moveTaskToBack();
        }
      },
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context).colorScheme.background,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Obx(
            () => FloatingDraggableWidget(
              floatingWidget:
                  controller.settings.value.dashboardSettings!.activated
                      ? InkWell(
                          onTap: () {
                            controller.displayDashboard.value =
                                !controller.displayDashboard.value;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.theme.colorScheme.tertiary,
                            ),
                            child: const Icon(
                              Icons.dashboard_rounded,
                              size: 26,
                            ),
                          ),
                        )
                      : Container(),
              floatingWidgetWidth: 40,
              floatingWidgetHeight: 100,
              dy: 10,
              dx: 10,
              mainScreenWidget: Listener(
                onPointerUp: (_) => {
                  FocusScope.of(context).unfocus(),
                },
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.background,
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
                            gripColorActive:
                                context.theme.colorScheme.secondary,
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
                            onWeightChanged: (weight) {
                              controller.settings.value =
                                  controller.settings.value.copyWith(
                                generalSettings: controller
                                    .settings.value.generalSettings
                                    ?.copyWith(
                                  splitViewWeights: [weight[0]!, weight[1]!],
                                ),
                              );
                              controller.saveSettings();
                            },
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
                          visible:
                              Get.find<StoreController>().purchasePending.value,
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
      ),
    );
  }

  Widget _top(BuildContext context, double height, double width) {
    return Container(
      color: Theme.of(context).colorScheme.background,
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
      color: Theme.of(context).colorScheme.background,
      child: Stack(
        children: [
          Listener(
            onPointerUp: (_) => {
              controller.isPickingEmote.value = false,
            },
            child: controller.channels.isNotEmpty
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
                        visible: controller.channels.length > 1,
                        child: _tabBarChats(context),
                      ),
                      _chats(context),
                    ],
                  )
                : Container(),
          ),
          Visibility(
            visible: controller.isPickingEmote.value,
            child: Positioned(
              bottom: 50,
              top: 50,
              left: 10,
              right: 150,
              child: EmotePickerView(homeViewController: controller),
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
        labelColor: Theme.of(context).colorScheme.tertiary,
        unselectedLabelColor: Theme.of(context).textTheme.bodyLarge!.color,
        indicatorColor: Theme.of(context).colorScheme.tertiary,
        labelPadding: const EdgeInsets.symmetric(horizontal: 30),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 2,
        dividerColor: Colors.transparent,
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
                      : controller.tabElements[index] is TwitchTabView
                          ? "Twitch"
                          : controller.tabElements[index] is WebPageView
                              ? (controller.tabElements[index] as WebPageView)
                                  .title
                              : "",
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomNavBar(double height, double width, BuildContext context) {
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
                            if (controller.selectedChatGroup == null) return;
                            ChatViewController chatViewController =
                                Get.find<ChatViewController>(
                                    tag: controller.selectedChatGroup!.id);
                            List<TwitchChat> twitchChats = [];
                            twitchChats.addAll(
                                chatViewController.twitchChats.toList());
                            if (twitchChats.length == 1) {
                              controller.sendChatMessage(value, twitchChats.first.channel);
                              controller.chatInputController.text = '';
                              FocusScope.of(context).unfocus();
                            } else {
                              selectChatToSend(
                                  context, controller, twitchChats, value);
                            }
                          },
                          onTap: () {
                            controller.selectedMessage.value = null;
                            controller.isPickingEmote.value = false;
                          },
                          textInputAction: TextInputAction.send,
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .backgroundColor,
                                fontSize: 16),
                            hintText: controller.settings.value.generalSettings!
                                    .displayViewerCount
                                ? '${Get.find<TwitchTabViewController>().twitchStreamInfos.value.viewerCount} viewers'
                                : 'send_message'.tr,
                            isDense: true,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 5),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.selectedChatGroup == null) return;
                          ChatViewController chatViewController =
                              Get.find<ChatViewController>(
                                  tag: controller.selectedChatGroup!.id);
                          List<TwitchChat> twitchChats = [];
                          twitchChats
                              .addAll(chatViewController.twitchChats.toList());
                          if (twitchChats.length == 1) {
                            controller.sendChatMessage(
                                controller.chatInputController.text, twitchChats.first.channel);
                            controller.chatInputController.text = '';
                            FocusScope.of(context).unfocus();
                          } else {
                            selectChatToSend(context, controller, twitchChats,
                                controller.chatInputController.text);
                          }
                        },
                        child: SvgPicture.asset(
                          './lib/assets/sendArrow.svg',
                          semanticsLabel: 'send message',
                          width: 21,
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
                                  Theme.of(context).colorScheme.background,
                              surfaceTintColor:
                                  Theme.of(context).colorScheme.background,
                              content: Container(
                                width: width,
                                color: Theme.of(context).colorScheme.background,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(
                                      () => poll(
                                        context,
                                        Get.find<TwitchTabViewController>(),
                                        Get.find<TwitchTabViewController>()
                                            .twitchEventSub!
                                            .currentPoll
                                            .value,
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
                                  Theme.of(context).colorScheme.background,
                              surfaceTintColor:
                                  Theme.of(context).colorScheme.background,
                              content: Container(
                                width: width,
                                color: Theme.of(context).colorScheme.background,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(
                                      () => prediction(
                                        context,
                                        Get.find<TwitchTabViewController>(),
                                        Get.find<TwitchTabViewController>()
                                            .twitchEventSub!
                                            .currentPrediction
                                            .value,
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
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () async {
                await Get.toNamed(
                  Routes.settings,
                );
                await controller.getSettings();
                if (controller.twitchData != null) {
                  for (var chan in controller.channels) {
                    if (Get.isRegistered<ChatViewController>(
                        tag: chan.chatGroup.id)) {
                      ChatViewController c =
                          Get.find<ChatViewController>(tag: chan.chatGroup.id);
                      ChatGroup? chatGroupUpdated = controller
                          .settings.value.chatSettings?.chatGroups
                          .firstWhereOrNull((cg) => cg.id == chan.chatGroup.id);
                      if (chatGroupUpdated != null) {
                        c.chatGroup = chatGroupUpdated;
                      }
                      c.applySettings();
                    }
                  }
                }
                controller.obsTabViewController?.applySettings();
                controller.streamelementsViewController?.applySettings();
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
        color: Theme.of(context).colorScheme.background,
        child: IndexedStack(
          index: controller.tabIndex.value,
          children: List<Widget>.generate(
            controller.tabElements.length,
            (int index) => controller.tabElements[index],
          ),
        ),
      ),
    );
  }

  Widget _tabBarChats(BuildContext context) {
    return TabBar(
      controller: controller.chatTabsController,
      isScrollable: true,
      labelColor: Theme.of(context).colorScheme.tertiary,
      unselectedLabelColor: Theme.of(context).textTheme.bodyLarge!.color,
      indicatorColor: Theme.of(context).colorScheme.tertiary,
      labelPadding: const EdgeInsets.symmetric(horizontal: 30),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 0.01,
      dividerColor: Colors.transparent,
      onTap: (int i) {
        if (Get.isRegistered<ChatViewController>(
            tag: controller.channels[i].chatGroup.id)) {
          ChatViewController c = Get.find<ChatViewController>(
              tag: controller.channels[i].chatGroup.id);
          c.scrollToBottom();
          controller.selectedChatGroup = c.chatGroup;
        }
        controller.selectedMessage.value = null;
        controller.selectedChatIndex = i;
      },
      tabs: List<Tab>.generate(
        controller.channels.length,
        (int index) => Tab(
          height: 30,
          child: Text(
              controller.channels[index].chatGroup.channels
                  .map((e) => e.channel)
                  .join(", "),
              style: Theme.of(context).textTheme.bodyLarge),
        ),
      ),
    );
  }

  Widget _chats(BuildContext context) {
    return Expanded(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.chatTabsController,
          children: List<Widget>.generate(
            controller.channels.length,
            (int index) => KeepAlive(
              chat: controller.channels[index],
              key: ValueKey(controller.channels[index]),
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
