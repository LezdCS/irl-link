import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/chat_view_controller.dart';

class ModerationBottomSheet extends StatelessWidget {
  final ChatViewController controller;
  final double width;

  const ModerationBottomSheet({
    super.key,
    required this.controller,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
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
              Text(
                controller.homeViewController.selectedMessage.value
                        ?.displayName ??
                    "",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Wrap(
                children: [
                  InkWell(
                    onTap: () => launchUrl(
                      Uri(
                        scheme: "https",
                        host: "twitch.tv",
                        path: controller.homeViewController.selectedMessage
                            .value?.displayName,
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
              Clipboard.setData(ClipboardData(
                  text: controller
                          .homeViewController.selectedMessage.value?.message ??
                      ""));
              Get.snackbar("Copied", "Message copied to clipboard");
            },
            child: Text(
              controller.homeViewController.selectedMessage.value?.message ??
                  "",
              style: const TextStyle(
                color: Color(0xFF575757),
                fontStyle: FontStyle.italic,
                fontSize: 14,
              ),
            ),
          ),
          InkWell(
            onTap: () => controller.deleteMessageInstruction(
              controller.homeViewController.selectedMessage.value!,
            ),
            child: moderationViewButton(null, "Delete message"),
          ),
          const SizedBox(height: 15),
          Row(children: [
            InkWell(
              onTap: () => controller.banMessageInstruction(
                controller.homeViewController.selectedMessage.value!,
              ),
              child: moderationViewButton(Icons.stop, "Ban"),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () => timeoutDialog(),
              child: moderationViewButton(Icons.timer, "Timeout"),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () => controller.hideUser(
                  controller.homeViewController.selectedMessage.value!),
              child: (controller
                          .homeViewController.settings.value.hiddenUsersIds!
                          .firstWhereOrNull((userId) =>
                              controller.homeViewController.selectedMessage
                                  .value!.authorId ==
                              userId) !=
                      null)
                  ? moderationViewButton(Icons.visibility, "Unhide user")
                  : moderationViewButton(Icons.visibility_off, "Hide user"),
            ),
          ]),
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
                    style: const TextStyle(color: Colors.white),
                    maxLines: 1,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                      hintText: 'Custom duration (s)',
                      isDense: true,
                      contentPadding: EdgeInsets.only(left: 5),
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
