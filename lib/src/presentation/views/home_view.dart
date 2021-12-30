import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/widgets/chat_view.dart';
import 'package:irllink/src/presentation/widgets/emote_picker_view.dart';
import 'package:irllink/src/presentation/widgets/obs_tab_view.dart';
import 'package:irllink/src/presentation/widgets/split_view_custom.dart';
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
        appBar: AppBar(
          backgroundColor: Color(0xFF121212),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _tabBar(height, width),
            ],
          ),
        ),
        body: Obx(
          () => Stack(
            children: [
              GestureDetector(
                onTap: () => {
                  debugPrint("trigereddddd"),
                  FocusScope.of(context).unfocus(),
                  controller.isPickingEmote.value = false,
                },
                child: Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    color: Color(0xFF121212),
                  ),
                  child: SafeArea(
                    child: SplitViewCustom(
                      controller: controller.splitViewController,
                      gripColor: Color(0xFF121212),
                      gripColorActive: Color(0xFF121212),
                      gripSize: 14,
                      viewMode: SplitViewMode.Vertical,
                      indicator: SplitIndicator(
                        viewMode: SplitViewMode.Vertical,
                        color: Color(0xFFFFFFFF),
                      ),
                      activeIndicator: SplitIndicator(
                        color: Color(0xFFFFFFFF),
                        viewMode: SplitViewMode.Vertical,
                        isActive: true,
                      ),
                      children: [
                        _tabsViews(),
                        Listener(
                          onPointerUp: (_) => {
                            controller.isPickingEmote.value = false,
                          },
                          child: ChatView(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: _bottomNavBar(height, width, context),
              ),
              Visibility(
                visible: controller.isPickingEmote.value,
                child: Positioned(
                  bottom: height * 0.07,
                  left: 10,
                  child: EmotePickerView(homeViewController: controller),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabBar(double height, double width) {
    return TabBar(
      controller: controller.tabController,
      isScrollable: true,
      labelColor: Colors.purple,
      unselectedLabelColor: Colors.white,
      indicatorColor: Colors.purple,
      labelPadding: EdgeInsets.symmetric(
          horizontal: width / (controller.tabElements.length > 2 ? 9 : 5)),
      tabs: List<Tab>.generate(
        controller.tabElements.length,
        (int index) => Tab(
          child: Text(
            controller.tabElements[index] is ObsTabView
                ? "OBS"
                : controller.tabElements[index] is TwitchTabView
                    ? "Twitch"
                    : controller.tabElements[index] is WebPageView
                        ? (controller.tabElements[index] as WebPageView).title
                        : "",
          ),
        ),
      ),
    );
  }

  Widget _bottomNavBar(double height, double width, BuildContext context) {
    return Obx(
      () => Container(
        height: height * 0.06,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              width: width * 0.7,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    child: SvgPicture.asset(
                      './lib/assets/chatinput.svg',
                      semanticsLabel: 'chat input',
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
                            style: TextStyle(color: Colors.white),
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 16),
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
            Container(
              width: width * 0.15,
              child: InkWell(
                onTap: () {
                  controller.sound.value = !controller.sound.value;
                },
                child: Icon(
                  controller.sound.value ? Icons.volume_up : Icons.volume_off,
                  color:
                      controller.sound.value ? Colors.white : Color(0xFFd63031),
                  size: 22,
                ),
              ),
            ),
            Container(
              width: width * 0.15,
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.SETTINGS);
                },
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabsViews() {
    return Container(
      color: Color(0xFF282828),
      child: TabBarView(
        physics:
            NeverScrollableScrollPhysics(), //used so if the user scroll horizontally it wont change of tabView, might delete it later, to discuss
        controller: controller.tabController,
        children: List<Widget>.generate(
          controller.tabElements.length,
          (int index) => controller.tabElements[index],
        ),
      ),
    );
  }
}
