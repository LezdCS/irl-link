import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart'
    show Platform;
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/presentation/controllers/chat_view_controller.dart';
import 'package:irllink/src/presentation/controllers/chats_controller.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/views/chat_view.dart';
import 'package:irllink/src/presentation/widgets/hype_train.dart';

class ChatsView extends GetView<ChatsController> {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: Get.find<HomeViewController>().twitchEventSubService != null,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              top: 4,
            ),
            child: Get.find<HomeViewController>().twitchEventSubService != null
                ? hypeTrain(
                    context,
                    Get.find<HomeViewController>()
                        .twitchEventSubService!
                        .currentHypeTrain
                        .value,
                    Get.find<HomeViewController>()
                        .twitchEventSubService!
                        .remainingTimeHypeTrain
                        .value,
                  )
                : Container(),
          ),
        ),
        Visibility(
          visible: controller.chatsViews.length > 1 ||
              controller.chatsViews.first.chatGroup.channels.length > 1,
          child: _tabBarChats(context),
        ),
        _chats(context),
      ],
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
      }
    }

    return Obx(() {
      int tabsLength = controller.chatsViews.length;

      return TabBar(
        controller: controller.chatTabsController.value,
        isScrollable: true,
        onTap: (int i) => controller.setTabIndex(i),
        tabs: List<Tab>.generate(
          tabsLength,
          (int index) {
            List<Channel> channels =
                controller.chatsViews[index].chatGroup.channels;
            return Tab(
              height: 30,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
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
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => _showReconnectDialog(context, index),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Icon(
                          Icons.refresh,
                          size: 16,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }

  void _showReconnectDialog(BuildContext context, int tabIndex) {
    List<Channel> channels = controller.chatsViews[tabIndex].chatGroup.channels;
    String channelNames = channels.map((c) => c.channel).join(', ');

    Get.defaultDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: "confirm".tr,
      middleText: "reconnect_question".trParams({
        "channel": channelNames,
      }),
      textConfirm: "confirm".tr,
      textCancel: "cancel".tr,
      confirmTextColor: Theme.of(context).textTheme.bodyLarge!.color,
      cancelTextColor: Theme.of(context).textTheme.bodyLarge!.color,
      buttonColor: Theme.of(context).colorScheme.tertiary,
      onConfirm: () {
        _reconnectTabChats(tabIndex);
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  void _reconnectTabChats(int tabIndex) {
    if (tabIndex >= 0 && tabIndex < controller.chatsViews.length) {
      String chatGroupId = controller.chatsViews[tabIndex].chatGroup.id;

      if (Get.isRegistered<ChatViewController>(tag: chatGroupId)) {
        ChatViewController chatController =
            Get.find<ChatViewController>(tag: chatGroupId);
        chatController.reconnectAllChats();
      }
    }
  }

  Widget _chats(BuildContext context) {
    return Expanded(
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: Obx(
          () => TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.chatTabsController.value,
            children: List<Widget>.generate(
              controller.chatsViews.length,
              (int index) => KeepAlive(
                chat: controller.chatsViews[index],
                key: ValueKey(controller.chatsViews[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
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
