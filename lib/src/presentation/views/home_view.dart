import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/widgets/chat_view.dart';
import 'package:irllink/src/presentation/widgets/emote_picker_view.dart';
import 'package:irllink/src/presentation/widgets/obs_tab_view.dart';
import 'package:irllink/src/presentation/widgets/split_view_custom.dart';
import 'package:irllink/src/presentation/widgets/streamelements_tab_view.dart';
import 'package:irllink/src/presentation/widgets/twitch_tab_view.dart';
import 'package:irllink/src/presentation/widgets/web_page_view.dart';
import 'package:move_to_background/move_to_background.dart';

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
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Obx(
          () => Stack(
            children: [
              GestureDetector(
                onTap: () => {
                  FocusScope.of(context).unfocus(),
                  controller.isPickingEmote.value = false,
                },
                child: Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    color: context.theme.primaryColor,
                  ),
                  child: SafeArea(
                    child: SplitViewCustom(
                      controller: controller.splitViewController,
                      gripColor: context.theme.colorScheme.secondary,
                      gripColorActive: context.theme.colorScheme.secondary,
                      gripSize: 14,
                      viewMode: context.isPortrait
                          ? SplitViewMode.Vertical
                          : SplitViewMode.Horizontal,
                      indicator: SplitIndicator(
                        viewMode: context.isPortrait
                            ? SplitViewMode.Vertical
                            : SplitViewMode.Horizontal,
                        color: Color(0xFFFFFFFF),
                      ),
                      activeIndicator: SplitIndicator(
                        color: Color(0xFFFFFFFF),
                        viewMode: context.isPortrait
                            ? SplitViewMode.Vertical
                            : SplitViewMode.Horizontal,
                        isActive: true,
                      ),
                      children: [
                        _top(context, height, width),
                        _bottom(context, height, width),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
          child: ChatView(),
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
        labelColor: Colors.purple,
        unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color,
        indicatorColor: Colors.purple,
        labelPadding: EdgeInsets.symmetric(
            horizontal: width / (controller.tabElements.length > 2 ? 9 : 5)),
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
    return Obx(
      () => Container(
        padding: EdgeInsets.only(left: 10),
        height: height * 0.06,
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    child: SvgPicture.asset(
                      './lib/assets/chatinput.svg',
                      semanticsLabel: 'chat input',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => controller.getEmotes(),
                          child: Image(
                            image:
                                AssetImage("lib/assets/twitchSmileEmoji.png"),
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
                              controller.chatViewController.selectedMessage
                                  .value = null;
                              controller.isPickingEmote.value = false;
                            },
                            textInputAction: TextInputAction.send,
                            style: Theme.of(context).textTheme.bodyText1,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  fontSize: 16),
                              hintText: 'Send a message',
                              isDense: true,
                              contentPadding: EdgeInsets.only(left: 5),
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
                onTap: () {
                  controller.sound.value = !controller.sound.value;
                },
                child: Icon(
                  controller.sound.value ? Icons.volume_up : Icons.volume_off,
                  color: controller.sound.value
                      ? Theme.of(context).primaryIconTheme.color
                      : Color(0xFFd63031),
                  size: 22,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () async {
                  await Get.toNamed(Routes.SETTINGS);
                  controller.getSettings();
                  controller.chatViewController.getSettings();
                  controller.obsTabViewController.getSettings();
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
      ),
    );
  }

  Widget _tabs(BuildContext context) {
    return Expanded(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller.tabController,
          children: List<Widget>.generate(
            controller.tabElements.length,
            (int index) => controller.tabElements[index],
          ),
        ),
      ),
    );
  }
}
