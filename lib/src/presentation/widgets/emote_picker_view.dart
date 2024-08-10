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

    List<Emote> globalEmotes = chatController.twitchChats[0].globalEmotes;
    List<Emote> userSetEmotes = chatController.twitchChats[0].emotesFromSets.where((e) => e.emoteType != EmoteType.global).toList();
    List<Emote> thirdPartEmotes = [];
    for(var chat in chatController.twitchChats){
      thirdPartEmotes.addAll(chat.thirdPartEmotes);
    }

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
          _tabBar(chatController),
          _tabs(context, globalEmotes, userSetEmotes, thirdPartEmotes),
        ],
      ),
    );
  }

  Widget _tabBar(ChatViewController chatController) {
    List<Tab> tabs = [
      const Tab(
        child: Image(
          image: AssetImage("lib/assets/twitch/twitch_logo.png"),
          width: 16,
        ),
      ),
       const Tab(
        child: Icon(Icons.star),
      ),
      const Tab(
        child: Icon(Icons.cable),
      ),
    ];

    homeViewController.emotesTabController =
        TabController(length: tabs.length, vsync: homeViewController);

    return TabBar(
      isScrollable: true,
      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
      tabAlignment: TabAlignment.start,
      controller: homeViewController.emotesTabController,
      onTap: (index) {
        homeViewController.emotesTabIndex.value = index;
      },
      tabs: tabs,
    );
  }

  Widget _tabs(BuildContext context, List<Emote> globalEmotes, List<Emote> userSetEmotes, List<Emote> thirdPartEmotes) {
    return Expanded(
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Obx(
          () => IndexedStack(
            index: homeViewController.emotesTabIndex.value,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                color: const Color(0xFF121212),
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 5),
                  itemCount: globalEmotes.length,
                  itemBuilder: (context, i) {
                    return _emote(globalEmotes[i]);
                  },
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                color: const Color(0xFF121212),
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 5),
                  itemCount: userSetEmotes.length,
                  itemBuilder: (context, i) {
                    return _emote(userSetEmotes[i]);
                  },
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                color: const Color(0xFF121212),
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 5),
                  itemCount: thirdPartEmotes.length,
                  itemBuilder: (context, i) {
                    return _emote(thirdPartEmotes[i]);
                  },
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
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
