import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/controllers/chat_view_controller.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/badges.dart';
import 'package:url_launcher/url_launcher.dart';

class ModerationBottomSheet extends GetView {
  @override
  final ChatViewController controller;

  const ModerationBottomSheet({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    ChatMessage? message = controller.homeViewController.selectedMessage.value;
    Settings settings = Get.find<SettingsService>().settings.value;

    if (message == null) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFa970ff)),
        color: const Color(0xFF18181b),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  //for every badge in message.badgesList, display the badge
                  Badges(
                    badges: message.badgesList,
                    textSize: 20,
                  ),
                  Text(
                    message.displayName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Wrap(
                children: [
                  InkWell(
                    onTap: () => launchUrl(
                      Uri(
                        scheme: "https",
                        host: message.platform == Platform.twitch
                            ? "twitch.tv"
                            : 'kick.com',
                        path: controller
                            .homeViewController.selectedMessage.value?.username,
                      ),
                      mode: LaunchMode.externalApplication,
                    ),
                    child: const Icon(
                      Icons.open_in_browser,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () => controller
                        .homeViewController.selectedMessage.value = null,
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onLongPress: () {
              Clipboard.setData(
                ClipboardData(text: message.message),
              );
              Get.snackbar(
                "Copied",
                "Message copied to clipboard",
              );
            },
            child: Text(
              message.message,
              style: const TextStyle(
                color: Color(0xFF575757),
                fontStyle: FontStyle.italic,
                fontSize: 14,
              ),
            ),
          ),
          Visibility(
            visible: message.platform == Platform.twitch,
            child: InkWell(
              onTap: () => controller.deleteMessageInstruction(
                message,
              ),
              child: moderationViewButton(null, "delete_message".tr),
            ),
          ),
          const SizedBox(height: 15),
          Visibility(
            visible: message.platform == Platform.twitch,
            child: Row(children: [
              InkWell(
                onTap: () => controller.banMessageInstruction(
                  message,
                ),
                child: moderationViewButton(Icons.stop, "ban".tr),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () => timeoutDialog(),
                child: moderationViewButton(Icons.timer, "timeout".tr),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () => controller.hideUser(
                  message,
                ),
                child: (settings.hiddenUsersIds!.firstWhereOrNull(
                          (userId) => message.authorId == userId,
                        ) !=
                        null)
                    ? moderationViewButton(Icons.visibility, "unhide_user".tr)
                    : moderationViewButton(
                        Icons.visibility_off, "hide_user".tr),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget moderationViewButton(IconData? icon, String message) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
      decoration: const BoxDecoration(
        color: Color(0xFF0e0e10),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        clipBehavior: Clip.none,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void timeoutDialog() {
    final List<Map<String, int>> timeoutValues = [
      {"10s": 10},
      {"1m": 60},
      {"10m": 600},
      {"30m": 1800},
    ];

    Get.defaultDialog(
      title: "Timeout",
      titleStyle: const TextStyle(color: Colors.white),
      backgroundColor: const Color(0xFF0e0e10),
      buttonColor: const Color(0xFF9147ff),
      cancelTextColor: const Color(0xFF9147ff),
      textCancel: "cancel".tr,
      radius: 10,
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(timeoutValues.length, (index) {
              return InkWell(
                onTap: () => controller.timeoutMessageInstruction(
                  controller.homeViewController.selectedMessage.value!,
                  timeoutValues[index].values.first,
                ),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 5),
                  decoration: const BoxDecoration(
                    color: Color(0xFF121212),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text(
                    timeoutValues[index].keys.first,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color(0xFF121212),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: TextField(
                    controller: controller.banDurationInputController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (String value) {
                      if (int.tryParse(value) != null) {
                        controller.timeoutMessageInstruction(
                          controller.homeViewController.selectedMessage.value!,
                          int.parse(value),
                        );
                      }
                    },
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: 'Custom duration (s)',
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    if (int.tryParse(
                            controller.banDurationInputController.text) !=
                        null) {
                      controller.timeoutMessageInstruction(
                        controller.homeViewController.selectedMessage.value!,
                        int.parse(controller.banDurationInputController.text),
                      );
                    }
                  },
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
