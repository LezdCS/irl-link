import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/presentation/controllers/chat_view_controller.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/widgets/chat_view.dart';
import 'package:irllink/src/presentation/widgets/dashboard.dart';
import 'package:irllink/src/presentation/widgets/emote_picker_view.dart';
import 'package:irllink/src/presentation/widgets/tabs/obs_tab_view.dart';
import 'package:irllink/src/presentation/widgets/tabs/streamelements_tab_view.dart';
import 'package:irllink/src/presentation/widgets/tabs/twitch_tab_view.dart';
import 'package:irllink/src/presentation/widgets/web_page_view.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:split_view/split_view.dart';

class HomeView extends GetView<HomeViewController> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context).colorScheme.background,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Obx(
            () => FloatingDraggableWidget(
              floatingWidget: const InkWell(
                  // onTap: () {
                  // controller.displayDashboard.value =
                  //     !controller.displayDashboard.value;
                  // },
                  // child: Container(
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: context.theme.colorScheme.tertiary,
                  //   ),
                  //   child: Icon(
                  //     Icons.dashboard_rounded,
                  //     size: 30,
                  //   ),
                  // ),
                  ),
              floatingWidgetWidth: 0,
              floatingWidgetHeight: 0,
              dy: height - 130,
              dx: width - 70,
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
                          child: Dashboard(
                            controller: controller,
                          ),
                        ),
                        Visibility(
                          visible: controller.purchasePending.value,
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
    return Column(
      children: [
        _tabBar(context, height, width),
        _tabs(context),
      ],
    );
  }

  Widget _bottom(BuildContext context, double height, double width) {
    return Stack(
      children: [
        Listener(
          onPointerUp: (_) => {
            controller.isPickingEmote.value = false,
          },
          child: Column(
            children: [
              Visibility(
                visible: controller.channels.length > 1,
                child: _tabBarChats(context),
              ),
              _chats(context),
            ],
          ),
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
                            controller.sendChatMessage(value);
                            FocusScope.of(context).unfocus();
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
                                    .color,
                                fontSize: 16),
                            hintText: 'send_message'.tr,
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
                              controller.chatInputController.text);
                          controller.chatInputController.text = '';
                          FocusScope.of(context).unfocus();
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
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () async {
                await Get.toNamed(
                  Routes.SETTINGS,
                );
                await controller.getSettings();
                if (controller.twitchData != null) {
                  for (var chan in controller.channels) {
                    ChatViewController c = Get.find<ChatViewController>(tag: chan.channel);
                    c.applySettings();
                  }
                }
                controller.obsTabViewController?.applySettings();
                controller.streamelementsViewController?.applySettings();
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
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.tabController,
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
        ChatViewController c =
            Get.find<ChatViewController>(tag: controller.channels[i].channel);
        controller.selectedChat.value = c.twitchChat;
        controller.selectedMessage.value = null;
        c.scrollToBottom();
      },
      tabs: List<Tab>.generate(
        controller.channels.length,
        (int index) => Tab(
          height: 30,
          child: Text(controller.channels[index].channel),
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
            (int index) => KeepAlive(chat: controller.channels[index]),
          ),
        ),
      ),
    );
  }
}

class KeepAlive extends StatefulWidget {
  KeepAlive({required this.chat});

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
