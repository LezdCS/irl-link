import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/chat_view_controller.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:twitch_chat/twitch_chat.dart';

class EmotePickerView extends GetView {
  final HomeViewController homeViewController;

  const EmotePickerView({
    super.key,
    required this.homeViewController,
  });

  @override
  Widget build(BuildContext context) {
    ChatViewController? chatController = Get.find<ChatViewController>(
      tag: homeViewController.selectedChatGroup.value?.id,
    );

    List<Emote> globalEmotes = chatController.twitchChats[0].emotes;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          _tabBar(),
          _tabs(context, globalEmotes),
        ],
      ),
    );
  }

  Widget _tabBar() {
    // Twitch globals, 7TV, FFZ, Twitch subs emotes
    return TabBar(
      isScrollable: true,
      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
      tabAlignment: TabAlignment.start,
      controller: homeViewController.emotesTabController,
      onTap: (index) {
        homeViewController.emotesTabIndex.value = index;
      },
      tabs: const [
        Tab(
          child: Image(
            image: AssetImage("lib/assets/twitch/twitch_logo.png"),
            width: 16,
          ),
        ),
        Tab(child: Text("7TV")),
        Tab(child: Text("FFZ")),
        Tab(child: Text("Twitch Subs")),
      ],
    );
  }

  Widget _tabs(BuildContext context, List<Emote> twitchEmotes) {
    return Expanded(
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Obx(
          () => IndexedStack(
            index: homeViewController.emotesTabIndex.value,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  color: const Color(0xFF121212),
                  child: GridView.builder(
                    padding: const EdgeInsets.only(top: 5),
                    itemCount: twitchEmotes.length,
                    itemBuilder: (context, i) {
                      return _emote(twitchEmotes[i]);
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
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

  Widget _emote(Emote emote) {
    return InkWell(
      onTap: () {
        String text = homeViewController.chatInputController.text;
        bool isLastCharSpace =
            text.isNotEmpty ? text[text.length - 1] == " " : false;
        homeViewController.chatInputController.text =
            "$text${isLastCharSpace ? "" : " "}${emote.name} ";
      },
      child: FadeInImage.memoryNetwork(
        image: emote.url1x,
        placeholder: kTransparentImage,
      ),
    );
  }
}
