import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/utils/string_casing_extension.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:uuid/uuid.dart';

class ChatsJoined extends GetView<SettingsViewController> {
  const ChatsJoined({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController channelTextController = TextEditingController();
    final SettingsService settingsService = Get.find<SettingsService>();
    return Obx(() {
      Settings settings = settingsService.settings.value;
      List<ChatGroup> chatGroups = settings.chatSettings.chatGroups;
      ChatGroup firstGroup = settings.chatSettings.permanentFirstGroup;
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
        body: DecoratedBox(
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
                  top: 12,
                ),
                child: Column(
                  children: [
                    Visibility(
                      visible: controller.homeViewController.twitchData.value !=
                          null,
                      child: Row(
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
                            controller.homeViewController.twitchData.value
                                    ?.twitchUser.displayName ??
                                '',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible:
                          controller.homeViewController.kickData.value != null,
                      child: Row(
                        children: [
                          const Image(
                            width: 18,
                            height: 18,
                            image: AssetImage(
                              "lib/assets/kick/kickLogo.png",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            controller.homeViewController.kickData.value
                                    ?.kickUser.name ??
                                '',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey[800],
                      height: 12,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: firstGroup.channels.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        Channel channel = firstGroup.channels[index];
                        return _channel(channel, firstGroup);
                      },
                    ),
                    _addChannelToGroupButton(
                      context,
                      channelTextController,
                      settings.chatSettings.permanentFirstGroup,
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
    final SettingsService settingsService = Get.find<SettingsService>();
    return Dismissible(
      key: ValueKey(group),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          children: [
            Text('delete'.tr),
            const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        // If the user swipes to the left
        if (direction == DismissDirection.endToStart) {
          Settings settings = settingsService.settings.value;

          // Remove the group from the list of groups in the settings
          settings.chatSettings.chatGroups.remove(group);
          // Save the settings and refresh the UI
          settingsService.saveSettings();
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
              padding: EdgeInsets.zero,
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
    final SettingsService settingsService = Get.find<SettingsService>();
    String badge = '';
    switch (channel.platform) {
      case Platform.twitch:
        badge = "lib/assets/twitch/twitch_logo.png";
      case Platform.kick:
        badge = "lib/assets/kick/kickLogo.png";
      case Platform.youtube:
        badge = "lib/assets/youtube/youtubeLogo.png";
    }
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          children: [
            Text('delete'.tr),
            const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) => Future.value(true),
      onDismissed: (direction) {
        // If the user swipes to the left
        if (direction == DismissDirection.endToStart) {
          // Remove the channel from the group
          group.channels.remove(channel);
          // Save the settings and refresh the UI
          settingsService.saveSettings();
        }
      },
      key: ValueKey(channel),
      child: Row(
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
    final SettingsService settingsService = Get.find<SettingsService>();
    Settings settings = settingsService.settings.value;

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
            ChatGroup updatedGroup = chatGroup.copyWith(channels: channels);

            if (updatedGroup.id == 'permanentFirstGroup') {
              settingsService.settings.value = settings.copyWith(
                chatSettings: settings.chatSettings
                    .copyWith(permanentFirstGroup: updatedGroup),
              );
            } else {
              // Replace the group in the list
              List<ChatGroup>? groups = [];
              groups.addAll(settings.chatSettings.chatGroups);
              int indexToReplace =
                  groups.indexWhere((g) => g.id == updatedGroup.id);
              groups.removeAt(indexToReplace);
              groups.insert(indexToReplace, updatedGroup);

              // Update the settings
              settingsService.settings.value = settings.copyWith(
                chatSettings:
                    settings.chatSettings.copyWith(chatGroups: groups),
              );
            }

            // Save and close dialog
            settingsService.saveSettings();

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
    final SettingsService settingsService = Get.find<SettingsService>();
    return InkWell(
      onTap: () {
        var uuid = const Uuid();
        ChatGroup newGroup = ChatGroup(
          id: uuid.v4(),
          channels: const [],
        );
        Settings settings = settingsService.settings.value;
        List<ChatGroup> chatGroups =
            List.from(settings.chatSettings.chatGroups);
        chatGroups.add(newGroup);
        settingsService.settings.value = settings.copyWith(
          chatSettings: settings.chatSettings.copyWith(chatGroups: chatGroups),
        );
        settingsService.saveSettings();
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('new_group'.tr),
            const Icon(Icons.add),
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
                    bool enabled = true;
                    switch (Platform.values[index]) {
                      case Platform.twitch:
                        badge = "lib/assets/twitch/twitch_logo.png";
                      case Platform.kick:
                        badge = "lib/assets/kick/kickLogo.png";
                      case Platform.youtube:
                        badge = "lib/assets/youtube/youtubeLogo.png";
                        enabled =
                            Get.find<HomeViewController>().twitchData.value !=
                                null;
                    }
                    return DropdownMenuItem(
                      value: Platform.values[index].toString(),
                      enabled: enabled,
                      child: enabled
                          ? Container(
                              decoration: BoxDecoration(
                                color:
                                    enabled ? null : Colors.grey.withAlpha(77),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              child: Row(
                                children: [
                                  Image(
                                    width: 18,
                                    height: 18,
                                    image: AssetImage(
                                      badge,
                                    ),
                                    filterQuality: FilterQuality.high,
                                    opacity: AlwaysStoppedAnimation(
                                      enabled ? 1.0 : 0.5,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                  ),
                                  Text(
                                    Platform.values[index].name.toCapitalized(),
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color
                                          ?.withAlpha(enabled ? 255 : 50),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Tooltip(
                              message:
                                  "YouTube chat requires Twitch authentication",
                              triggerMode: TooltipTriggerMode.tap,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.withAlpha(77),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: Row(
                                  children: [
                                    Image(
                                      width: 18,
                                      height: 18,
                                      image: AssetImage(
                                        badge,
                                      ),
                                      filterQuality: FilterQuality.high,
                                      opacity:
                                          const AlwaysStoppedAnimation(0.5),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 8),
                                    ),
                                    Text(
                                      Platform.values[index].name
                                          .toCapitalized(),
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color
                                            ?.withAlpha(50),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
        return 'Ex: Lezd in youtube.com/@Lezd';
    }
  }

  String _getHintText(Platform platform) {
    switch (platform) {
      case Platform.twitch:
        return 'Channel name';
      case Platform.kick:
        return 'Channel name';
      case Platform.youtube:
        return 'Channel handle';
    }
  }
}
