import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/chat/announcement_event.dart';
import 'package:irllink/src/domain/entities/chat/bit_donation_event.dart';
import 'package:irllink/src/domain/entities/chat/incoming_raid_event.dart';
import 'package:irllink/src/domain/entities/chat/reward_redemption_event.dart';
import 'package:irllink/src/domain/entities/chat/subscription_event.dart';
import 'package:irllink/src/domain/entities/chat/twitch_chat_message.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/widgets/chat_message/event_container.dart';

class ChatEvents extends StatelessWidget {
  final SettingsViewController controller;

  const ChatEvents({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [],
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          "Chat events",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 8),
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              Column(
                children: [
                  EventContainer(
                    message: TwitchChatMessage.randomGeneration(
                      HighlightType.firstTimeChatter,
                    ),
                    selectedMessage: null,
                    displayTimestamp: false,
                    textSize: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "First time chatter",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        value: true,
                        onChanged: (value) {},
                        inactiveTrackColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                        activeTrackColor:
                            Theme.of(context).colorScheme.tertiary,
                        activeColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  EventContainer(
                    message: SubscriptionEvent.randomGeneration(),
                    selectedMessage: null,
                    displayTimestamp: false,
                    textSize: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subscriptions",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        value: true,
                        onChanged: (value) {},
                        inactiveTrackColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                        activeTrackColor:
                            Theme.of(context).colorScheme.tertiary,
                        activeColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  EventContainer(
                    message: BitDonationEvent.randomGeneration(),
                    selectedMessage: null,
                    displayTimestamp: false,
                    textSize: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bits donations",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        value: true,
                        onChanged: (value) {},
                        inactiveTrackColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                        activeTrackColor:
                            Theme.of(context).colorScheme.tertiary,
                        activeColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  EventContainer(
                    message: AnnouncementEvent.randomGeneration(),
                    selectedMessage: null,
                    displayTimestamp: false,
                    textSize: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Announcements",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        value: true,
                        onChanged: (value) {},
                        inactiveTrackColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                        activeTrackColor:
                            Theme.of(context).colorScheme.tertiary,
                        activeColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              // Column(
              //   children: [
              //     //todo: display example of widget
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "Shoutouts",
              //           style: TextStyle(
              //             color: Theme.of(context).textTheme.bodyLarge!.color,
              //             fontSize: 18,
              //           ),
              //         ),
              //         Switch(
              //           value: true,
              //           onChanged: (value) {},
              //           inactiveTrackColor:
              //               Theme.of(context).colorScheme.tertiaryContainer,
              //           activeTrackColor:
              //               Theme.of(context).colorScheme.tertiary,
              //           activeColor: Colors.white,
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              Column(
                children: [
                  EventContainer(
                    message: IncomingRaidEvent.randomGeneration(),
                    selectedMessage: null,
                    displayTimestamp: false,
                    textSize: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Incoming raids",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        value: true,
                        onChanged: (value) {},
                        inactiveTrackColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                        activeTrackColor:
                            Theme.of(context).colorScheme.tertiary,
                        activeColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  EventContainer(
                    message: RewardRedemptionEvent.randomGeneration(),
                    selectedMessage: null,
                    displayTimestamp: false,
                    textSize: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Channelpoint redemptions",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        value: true,
                        onChanged: (value) {},
                        inactiveTrackColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                        activeTrackColor:
                            Theme.of(context).colorScheme.tertiary,
                        activeColor: Colors.white,
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
  }
}
