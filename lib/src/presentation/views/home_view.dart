import 'dart:ui';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/domain/entities/tabbar/web_page.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/widgets/obs_tab_view.dart';
import 'package:irllink/src/presentation/widgets/twitch_tab_view.dart';
import 'package:irllink/src/presentation/widgets/web_page_view.dart';
import 'package:irllink/src/presentation/widgets/split_view_custom.dart';
import 'package:irllink/src/domain/entities/twitch_chat_message.dart';

class HomeView extends GetView<HomeViewController> {
  final HomeViewController controller = Get.find<HomeViewController>();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => {
              FocusScope.of(context).unfocus(),
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
                  gripSize: 18,
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
                    _tabBarCustomWindows(height, width),
                    _twitchChat(height, width),
                  ],
                  onWeightChanged: (w) {
                    print("Horizon: $w");
                  },
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
        ],
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
                        Image(
                          image: AssetImage("lib/assets/twitchSmileEmoji.png"),
                          width: 30,
                        ),
                        Expanded(
                          child: TextField(
                            controller: controller.chatInputController,
                            onSubmitted: (String value) {
                              controller.sendChatMessage(value);
                              controller.chatInputController.text = '';
                              FocusScope.of(context).unfocus();
                            },
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

  Widget _tabBarCustomWindows(double height, double width) {
    return SizedBox(
      height: height / 2,
      width: width,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: Color(0xFF121212),
            bottom: TabBar(
              controller: controller.tabController,
              isScrollable: true,
              labelColor: Colors.purple,
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.purple,
              labelPadding: EdgeInsets.symmetric(
                  horizontal:
                      width / (controller.tabElements.length > 2 ? 9 : 5)),
              tabs: List<Tab>.generate(
                controller.tabElements.length,
                (int index) => Tab(
                  child: Text(
                    controller.tabElements[index].title,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SizedBox(
          height: double.infinity,
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller.tabController,
            children: List<Widget>.generate(
              controller.tabElements.length,
              (int index) => controller.tabElements[index] is WebPage
                  ? WebPageView(controller.tabElements[index].toWebPage().url)
                  : controller.tabElements[index].title == "Twitch"
                      ? TwitchTabView()
                      : controller.tabElements[index].title == "OBS"
                          ? ObsTabView()
                          : Container(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _twitchChat(double height, double width) {
    return Obx(
      () => Stack(children: [
        Container(
          width: width,
          padding: EdgeInsets.only(top: 10, left: 10, bottom: height * 0.07),
          decoration: BoxDecoration(
            color: Color(0xFF282828),
          ),
          child: ListView(
            controller: controller.scrollController,
            children: [
              Visibility(
                visible: controller.chatMessages.length < 100,
                child: Text(
                  "Welcome on ${controller.twitchData.twitchUser.displayName} 's chat room !",
                  style: TextStyle(
                    color: Color(0xFF878585),
                  ),
                ),
              ),
              for (TwitchChatMessage message in controller.chatMessages)
                chatMessage(message)
            ],
          ),
        ),
        AnimatedOpacity(
          opacity: controller.isChatConnected.value ? 0.0 : 1.0,
          duration: Duration(milliseconds: 1000),
          child: alertMessage(
            controller.isChatConnected.value
                ? Color(0xFF33A031)
                : Color(0xFFEC7508),
            controller.isChatConnected.value ? "Connected" : "Connecting...",
            !controller.isChatConnected.value,
          ),
        ),
      ]),
    );
  }

  Widget chatMessage(TwitchChatMessage message) {
    return Container(
      padding: EdgeInsets.only(top: 4),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          for (TwitchBadge badge in message.badges)
            Container(
              padding: EdgeInsets.only(right: 4, top: 3),
              child: Image(
                image: NetworkImage(badge.imageUrl1x),
                filterQuality: FilterQuality.high,
                alignment: Alignment.bottomLeft,
              ),
            ),
          Text(
            message.authorName + ": ",
            style: TextStyle(
              color: message.color != ''
                  ? Color(int.parse(message.color.replaceAll('#', '0xff')))
                  : Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          for (String word in message.message.trim().split(' '))
            if (message.emotes.entries.firstWhereOrNull((element) => element
                    .value
                    .where((position) =>
                        message.message.substring(int.parse(position[0]),
                            int.parse(position[1]) + 1) ==
                        word)
                    .isNotEmpty) !=
                null)
              Wrap(children: [
                Image(
                  image: NetworkImage(
                      "https://static-cdn.jtvnw.net/emoticons/v2/" +
                          message
                              .emotes.entries
                              .firstWhere((element) => element
                                  .value
                                  .where((position) =>
                                      message.message.substring(
                                          int.parse(position[0]),
                                          int.parse(position[1]) + 1) ==
                                      word)
                                  .isNotEmpty)
                              .key +
                          "/default/dark/1.0"),
                ),
                Text(' '),
              ])
            else
              Text(
                word + " ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ),
              ),
        ],
      ),
    );
  }

  Widget alertMessage(Color color, String message, bool isProgress) {
    return AnimatedContainer(
      padding: EdgeInsets.only(bottom: 5, top: 5),
      color: color,
      duration: Duration(milliseconds: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Visibility(
            visible: isProgress,
            child: Container(
              margin: EdgeInsets.only(left: 8),
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
