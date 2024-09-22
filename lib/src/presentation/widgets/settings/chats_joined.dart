import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/utils/string_casing_extension.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:uuid/uuid.dart';

class ChatsJoined extends GetView<SettingsViewController> {
  const ChatsJoined({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController channelTextController = TextEditingController();

    return Obx(() {
      Settings settings = Get.find<SettingsService>().settings.value;
      List<ChatGroup> chatGroups = settings.chatSettings?.chatGroups ?? [];
      ChatGroup firstGroup = settings.chatSettings!.permanentFirstGroup;
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            onPressed: () => Get.back(),
          ),
          actions: const [],
          title: Text(
            "chats_joined".tr,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            children: [
              Container(
                color: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 10,
                  top: 10,
                ),
                margin: const EdgeInsets.only(
                  bottom: 0,
                  top: 12,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                          width: 18,
                          height: 18,
                          image: AssetImage(
                            "lib/assets/twitch/twitch_logo.png",
                          ),
                          filterQuality: FilterQuality.high,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          controller.homeViewController.twitchData?.twitchUser
                                  .displayName ??
                              '',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: firstGroup.channels.length,
                      padding: const EdgeInsets.only(
                        bottom: 0,
                        top: 0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        Channel channel = firstGroup.channels[index];
                        return _channel(channel, firstGroup);
                      },
                    ),
                    _addChannelToGroupButton(
                      context,
                      channelTextController,
                      settings.chatSettings!.permanentFirstGroup,
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: chatGroups.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
                padding: const EdgeInsets.only(
                  bottom: 12,
                  top: 12,
                ),
                //   onReorder: (int oldIndex, int newIndex) {
                //     if (newIndex > oldIndex) {
                //       newIndex -= 1;
                //     }
                //     final element = controller.homeViewController.settings.value
                //         .chatSettings!.chatsJoined
                //         .removeAt(oldIndex);
                //     controller.homeViewController.settings.value.chatSettings!
                //         .chatsJoined
                //         .insert(newIndex, element);
                //   },
                itemBuilder: (BuildContext context, int index) {
                  ChatGroup group = chatGroups[index];
                  return Container(
                    key: ValueKey(
                      group,
                    ),
                    child: _group(context, channelTextController, group),
                  );
                },
              ),
              _addGroupButton(context),
            ],
          ),
        ),
      );
    });
  }

  Widget _group(context, channelTextController, ChatGroup group) {
    return Dismissible(
      key: ValueKey(group),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      onDismissed: (direction) {
        // If the user swipes to the left
        if (direction == DismissDirection.endToStart) {
          Settings settings = Get.find<SettingsService>().settings.value;

          // Remove the group from the list of groups in the settings
          settings.chatSettings?.chatGroups.remove(group);
          // Save the settings and refresh the UI
          Get.find<SettingsService>().saveSettings();
        }
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
          top: 10,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: group.channels.length,
              padding: const EdgeInsets.only(
                bottom: 0,
                top: 0,
              ),
              itemBuilder: (BuildContext context, int index) {
                Channel channel = group.channels[index];
                return _channel(channel, group);
              },
            ),
            _addChannelToGroupButton(context, channelTextController, group),
          ],
        ),
      ),
    );
  }

  Widget _channel(Channel channel, ChatGroup group) {
    String badge = '';
    switch (channel.platform) {
      case Platform.twitch:
        badge = "lib/assets/twitch/twitch_logo.png";
        break;
      case Platform.kick:
        badge = "lib/assets/kick/kickLogo.png";
        break;
      case Platform.youtube:
        badge = "lib/assets/youtube/youtubeLogo.png";
        break;
    }
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      confirmDismiss: (direction) => Future.value(true),
      onDismissed: (direction) {
        // If the user swipes to the left
        if (direction == DismissDirection.endToStart) {
          // Remove the channel from the group
          group.channels.remove(channel);
          // Save the settings and refresh the UI
          Get.find<SettingsService>().saveSettings();
        }
      },
      key: ValueKey(channel),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            width: 18,
            height: 18,
            image: AssetImage(
              badge,
            ),
            filterQuality: FilterQuality.high,
          ),
          const Padding(padding: EdgeInsets.only(right: 8)),
          Flexible(
            child: Text(
              channel.channel,
              style: const TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _addChannelToGroupButton(
    context,
    TextEditingController channelTextController,
    ChatGroup chatGroup,
  ) {
    Rx<Platform?> selectedPlatform = Platform.values.first.obs;
    Settings settings = Get.find<SettingsService>().settings.value;

    return InkWell(
      onTap: () {
        Get.defaultDialog(
          content: _addDialog(context, channelTextController, selectedPlatform),
          title: "add".tr,
          textCancel: "cancel".tr,
          textConfirm: "add".tr,
          titleStyle: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          buttonColor: const Color(0xFF9147ff),
          cancelTextColor: const Color(0xFF9147ff),
          confirmTextColor: Colors.white,
          radius: 10,
          onConfirm: () {
            // Create the new channel
            Channel newChan = Channel(
              platform: selectedPlatform.value!,
              channel: channelTextController.text.trim(),
              enabled: true,
            );

            // Add the new channel to the selected group
            List<Channel> channels = [...chatGroup.channels, newChan];
            chatGroup = chatGroup.copyWith(channels: channels);

            if (chatGroup.id == 'permanentFirstGroup') {
              Get.find<SettingsService>().settings.value = settings.copyWith(
                chatSettings: settings.chatSettings
                    ?.copyWith(permanentFirstGroup: chatGroup),
              );
            } else {
              // Replace the group in the list
              List<ChatGroup>? groups = [];
              groups.addAll(settings.chatSettings?.chatGroups ?? []);
              int indexToReplace =
                  groups.indexWhere((g) => g.id == chatGroup.id);
              groups.removeAt(indexToReplace);
              groups.insert(indexToReplace, chatGroup);

              // Update the settings
              Get.find<SettingsService>().settings.value = settings.copyWith(
                chatSettings:
                    settings.chatSettings?.copyWith(chatGroups: groups),
              );
            }

            // Save and close dialog
            Get.find<SettingsService>().saveSettings();

            channelTextController.text = '';
            Get.back();
          },
          onCancel: () {
            channelTextController.text = '';
          },
        );
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 12, top: 12),
        margin: const EdgeInsets.only(bottom: 5, top: 5, left: 12, right: 12),
        decoration: BoxDecoration(
          // dotted border
          border: Border.all(
            color: Theme.of(context).colorScheme.tertiary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "add".tr,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _addGroupButton(context) {
    return InkWell(
      onTap: () {
        var uuid = const Uuid();
        ChatGroup newGroup = ChatGroup(
          id: uuid.v4(),
          channels: const [],
        );
        Settings settings = Get.find<SettingsService>().settings.value;
        List<ChatGroup> chatGroups =
            List.from(settings.chatSettings!.chatGroups);
        chatGroups.add(newGroup);
        Get.find<SettingsService>().settings.value = settings.copyWith(
          chatSettings: settings.chatSettings!.copyWith(chatGroups: chatGroups),
        );
        Get.find<SettingsService>().saveSettings();
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
        margin: const EdgeInsets.only(left: 12, right: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('New group'),
            Icon(Icons.add),
          ],
        ),
      ),
    );
  }

  Widget _addDialog(context, channelTextController, selectedPlatform) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => Form(
            child: Column(
              children: [
                DropdownButton(
                  value: selectedPlatform.toString(),
                  items: List.generate(Platform.values.length, (index) {
                    String badge = '';
                    switch (Platform.values[index]) {
                      case Platform.twitch:
                        badge = "lib/assets/twitch/twitch_logo.png";
                        break;
                      case Platform.kick:
                        badge = "lib/assets/kick/kickLogo.png";
                        break;
                      case Platform.youtube:
                        badge = "lib/assets/youtube/youtubeLogo.png";
                        break;
                    }
                    return DropdownMenuItem(
                      value: Platform.values[index].toString(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            width: 18,
                            height: 18,
                            image: AssetImage(
                              badge,
                            ),
                            filterQuality: FilterQuality.high,
                          ),
                          const Padding(padding: EdgeInsets.only(right: 8)),
                          Text(
                            Platform.values[index].name
                                .toString()
                                .toCapitalized(),
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  onChanged: (value) {
                    Platform pFromS = Platform.values.firstWhere(
                      (element) => element.toString() == value,
                    );
                    selectedPlatform.value = pFromS;
                  },
                ),
                TextFormField(
                  controller: channelTextController,
                  textInputAction: TextInputAction.send,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the channel name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    helperText: _getHelperText(selectedPlatform.value),
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    hintText: _getHintText(selectedPlatform.value),
                    labelText: _getHintText(selectedPlatform.value),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getHelperText(Platform platform) {
    switch (platform) {
      case Platform.twitch:
        return '';
      case Platform.kick:
        return '';
      case Platform.youtube:
        return 'Ex: youtube.com/@Lezd/streams';
      default:
        return '';
    }
  }

  String _getHintText(Platform platform) {
    switch (platform) {
      case Platform.twitch:
        return 'Channel name';
      case Platform.kick:
        return 'Channel name';
      case Platform.youtube:
        return 'Channel URL';
      default:
        return '';
    }
  }
}
