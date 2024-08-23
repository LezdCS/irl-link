import 'package:flutter/material.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/event_container.dart';
import 'package:twitch_chat/twitch_chat.dart';

import 'package:irllink/src/domain/entities/chat/chat_message.dart' as entity;

class ChatEvents extends StatelessWidget {
  final SettingsViewController controller;

  const ChatEvents({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        Settings settings = Get.find<SettingsService>().settings.value;

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
              onPressed: () => Get.back(),
            ),
            actions: const [],
            title: const Text(
              "Chat events",
              style: TextStyle(),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 8),
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                children: [
                  Column(
                    children: [
                      EventContainer(
                        message: entity.ChatMessage.fromTwitch(
                          ChatMessage.randomGeneration(
                            HighlightType.firstTimeChatter,
                            "Hey guys, I'm new here!",
                            "Lezd",
                          ),
                          '',
                        ),
                        selectedMessage: null,
                        displayTimestamp: false,
                        textSize: 16,
                        hideDeletedMessages: false,
                        cheerEmotes: const [],
                        thirdPartEmotes: const [],
                        showPlatformBadge: false,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "First time chatter",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Switch(
                            value: settings.chatEventsSettings!.firstsMessages,
                            onChanged: (value) {
                              Get.find<SettingsService>().settings.value =
                                  settings.copyWith(
                                chatEventsSettings:
                                    settings.chatEventsSettings!.copyWith(
                                  firstsMessages: value,
                                ),
                              );
                              Get.find<SettingsService>().saveSettings();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    height: 20,
                  ),
                  Column(
                    children: [
                      EventContainer(
                        message: entity.ChatMessage.fromTwitch(
                          Subscription.randomGeneration(),
                          '',
                        ),
                        selectedMessage: null,
                        displayTimestamp: false,
                        textSize: 16,
                        hideDeletedMessages: false,
                        cheerEmotes: const [],
                        thirdPartEmotes: const [],
                        showPlatformBadge: false,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Subscriptions",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Switch(
                            value: settings.chatEventsSettings!.subscriptions,
                            onChanged: (value) {
                              Get.find<SettingsService>().settings.value =
                                  settings.copyWith(
                                chatEventsSettings:
                                    settings.chatEventsSettings!.copyWith(
                                  subscriptions: value,
                                ),
                              );
                              Get.find<SettingsService>().saveSettings();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    height: 20,
                  ),
                  Column(
                    children: [
                      EventContainer(
                        message: entity.ChatMessage.fromTwitch(
                          BitDonation.randomGeneration(),
                          '',
                        ),
                        selectedMessage: null,
                        displayTimestamp: false,
                        textSize: 16,
                        hideDeletedMessages: false,
                        cheerEmotes: const [],
                        thirdPartEmotes: const [],
                        showPlatformBadge: false,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Bits donations",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Switch(
                            value: settings.chatEventsSettings!.bitsDonations,
                            onChanged: (value) {
                              Get.find<SettingsService>().settings.value =
                                  settings.copyWith(
                                chatEventsSettings:
                                    settings.chatEventsSettings!.copyWith(
                                  bitsDonations: value,
                                ),
                              );
                              Get.find<SettingsService>().saveSettings();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    height: 20,
                  ),
                  Column(
                    children: [
                      EventContainer(
                        message: entity.ChatMessage.fromTwitch(
                          Announcement.randomGeneration(),
                          '',
                        ),
                        selectedMessage: null,
                        displayTimestamp: false,
                        textSize: 16,
                        hideDeletedMessages: false,
                        cheerEmotes: const [],
                        thirdPartEmotes: const [],
                        showPlatformBadge: false,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Announcements",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Switch(
                            value: settings.chatEventsSettings!.announcements,
                            onChanged: (value) {
                              Get.find<SettingsService>().settings.value =
                                  settings.copyWith(
                                chatEventsSettings:
                                    settings.chatEventsSettings!.copyWith(
                                  announcements: value,
                                ),
                              );
                              Get.find<SettingsService>().saveSettings();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    height: 20,
                  ),
                  Column(
                    children: [
                      EventContainer(
                        message: entity.ChatMessage.fromTwitch(
                          IncomingRaid.randomGeneration(),
                          '',
                        ),
                        selectedMessage: null,
                        displayTimestamp: false,
                        textSize: 16,
                        hideDeletedMessages: false,
                        cheerEmotes: const [],
                        thirdPartEmotes: const [],
                        showPlatformBadge: false,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Incoming raids",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Switch(
                            value: settings.chatEventsSettings!.incomingRaids,
                            onChanged: (value) {
                              Get.find<SettingsService>().settings.value =
                                  settings.copyWith(
                                chatEventsSettings:
                                    settings.chatEventsSettings!.copyWith(
                                  incomingRaids: value,
                                ),
                              );
                              Get.find<SettingsService>().saveSettings();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    height: 20,
                  ),
                  Column(
                    children: [
                      EventContainer(
                        message: entity.ChatMessage.fromTwitch(
                          RewardRedemption.randomGeneration(),
                          '',
                        ),
                        selectedMessage: null,
                        displayTimestamp: false,
                        textSize: 16,
                        hideDeletedMessages: false,
                        cheerEmotes: const [],
                        thirdPartEmotes: const [],
                        showPlatformBadge: false,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Channelpoint redemptions",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Switch(
                            value: settings.chatEventsSettings!.redemptions,
                            onChanged: (value) {
                              Get.find<SettingsService>().settings.value =
                                  settings.copyWith(
                                chatEventsSettings:
                                    settings.chatEventsSettings!.copyWith(
                                  redemptions: value,
                                ),
                              );
                              Get.find<SettingsService>().saveSettings();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
