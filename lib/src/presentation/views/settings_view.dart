import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:irllink/src/presentation/controllers/store_controller.dart';
import 'package:irllink/src/presentation/widgets/settings/chat_events.dart';
import 'package:irllink/src/presentation/widgets/settings/dashboard_settings_view.dart';
import 'package:irllink/src/presentation/widgets/settings/realtime_irl.dart';
import 'package:irllink/src/presentation/widgets/settings/stream_elements.dart';
import 'package:irllink/src/presentation/widgets/settings/talker_screen.dart';
import 'package:irllink/src/presentation/widgets/settings/tts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;

import '../../core/resources/app_translations.dart';
import '../widgets/settings/chats_joined.dart';
import '../widgets/settings/manage_list_hidden_users.dart';
import '../widgets/settings/manage_list_browser_tabs.dart';
import '../widgets/settings/obs_settings.dart';
import '../widgets/settings/subscription.dart';

class SettingsView extends GetView<SettingsViewController> {
  @override
  final SettingsViewController controller = Get.find<SettingsViewController>();

  SettingsView({super.key});

  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Get.back(),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 6, top: 10, bottom: 10),
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: TextButton(
                onPressed: () {
                  if (controller.homeViewController.twitchData != null) {
                    controller.logout();
                  } else {
                    controller.login();
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      controller.homeViewController.twitchData != null
                          ? Colors.red
                          : Colors.purple,
                ),
                child: Text(
                  controller.homeViewController.twitchData != null
                      ? "Logout"
                      : "Login",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: const Text(
            "Settings",
          ),
          centerTitle: false,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: ListView(
            padding:
                const EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 8),
            children: [
              Subscription(controller: controller),
              const Divider(
                height: 20,
              ),
              chatSettings(context, width),
              Divider(
                height: 20,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              connectionsSettings(context, width),
              const Divider(
                height: 20,
              ),
              generalSettings(context, width),
              const Divider(
                height: 20,
              ),
              contactSettings(context, width),
              Container(
                padding: const EdgeInsets.only(left: 4, right: 4, top: 6),
                child: Text("Version: ${globals.version}"),
              ),
              settingsGoToRow(
                context,
                'Logs',
                Icons.list_alt,
                () {
                  Get.to(
                    () => TalkerScreenView(
                      talker: globals.talker!,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget chatSettings(BuildContext context, double width) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chat",
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary, fontSize: 20),
          ),
          Container(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "FFZ, BTTV & 7TV emotes",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Switch(
                      onChanged: (value) {
                        controller.homeViewController.settings.value =
                            controller.homeViewController.settings.value
                                .copyWith(isEmotes: value);
                        controller.saveSettings();
                      },
                      value: controller
                          .homeViewController.settings.value.isEmotes!,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "text_size".tr,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                        controller.homeViewController.settings.value.textSize!
                            .ceil()
                            .toString(),
                        style: const TextStyle(fontSize: 18)),
                    Slider(
                      onChanged: (value) {
                        controller.homeViewController.settings.value =
                            controller.homeViewController.settings.value
                                .copyWith(textSize: value);
                        controller.saveSettings();
                      },
                      value: controller
                          .homeViewController.settings.value.textSize!,
                      min: 0.0,
                      max: 50.0,
                      divisions: 100,
                      label:
                          "${controller.homeViewController.settings.value.textSize}",
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "show_timestamp".tr,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Switch(
                      onChanged: (value) {
                        controller.homeViewController.settings.value =
                            controller.homeViewController.settings.value
                                .copyWith(displayTimestamp: value);
                        controller.saveSettings();
                      },
                      value: controller
                          .homeViewController.settings.value.displayTimestamp!,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Hide deleted messages",
                      style: TextStyle(fontSize: 18),
                    ),
                    Switch(
                      onChanged: (value) {
                        controller.homeViewController.settings.value =
                            controller.homeViewController.settings.value
                                .copyWith(
                                    chatSettings: controller.homeViewController
                                        .settings.value.chatSettings
                                        ?.copyWith(hideDeletedMessages: value));

                        controller.saveSettings();
                      },
                      value: controller.homeViewController.settings.value
                          .chatSettings!.hideDeletedMessages,
                    )
                  ],
                ),
                settingsGoToRow(
                  context,
                  "Chats joined",
                  Icons.wechat_sharp,
                  () {
                    Get.to(
                      () => const ChatsJoined(),
                    );
                  },
                ),
                settingsGoToRow(
                  context,
                  "Chat events",
                  Icons.reviews,
                  () {
                    Get.to(
                      () => ChatEvents(
                        controller: controller,
                      ),
                    );
                  },
                ),
                settingsGoToRow(
                  context,
                  "manage_hidden_users".tr,
                  Icons.list,
                  () {
                    Get.to(
                      () => ManageListHiddenUsers(
                        controller: controller,
                      ),
                    );
                  },
                ),
                settingsGoToRow(
                  context,
                  "text_to_speech".tr,
                  Icons.spatial_audio_off_rounded,
                  () {
                    Get.to(
                      () => Tts(
                        controller: controller,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget generalSettings(BuildContext context, double width) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "General",
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary, fontSize: 20),
          ),
          Container(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                settingsGoToRow(
                  context,
                  "Dashboard",
                  Icons.dashboard,
                  () {
                    Get.to(
                      () => const DashboardSettingsView(),
                    );
                  },
                ),
                //Themes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "dark_mode".tr,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Switch(
                      onChanged: (value) {
                        value
                            ? Get.changeThemeMode(ThemeMode.dark)
                            : Get.changeThemeMode(ThemeMode.light);
                        controller.homeViewController.settings.value =
                            controller.homeViewController.settings.value
                                .copyWith(
                          generalSettings: controller
                              .homeViewController.settings.value.generalSettings
                              ?.copyWith(isDarkMode: value),
                        );
                        controller.saveSettings();
                      },
                      value: controller.homeViewController.settings.value
                          .generalSettings!.isDarkMode,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "prevent_speaker".tr,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Switch(
                      onChanged: (value) {
                        controller.homeViewController.settings.value =
                            controller.homeViewController.settings.value
                                .copyWith(
                          generalSettings: controller
                              .homeViewController.settings.value.generalSettings
                              ?.copyWith(keepSpeakerOn: value),
                        );
                        controller.saveSettings();
                      },
                      value: controller.homeViewController.settings.value
                          .generalSettings!.keepSpeakerOn,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "Display viewer count",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Switch(
                      onChanged: (value) {
                        controller.homeViewController.settings.value =
                            controller.homeViewController.settings.value
                                .copyWith(
                          generalSettings: controller
                              .homeViewController.settings.value.generalSettings
                              ?.copyWith(displayViewerCount: value),
                        );
                        controller.saveSettings();
                      },
                      value: controller.homeViewController.settings.value
                          .generalSettings!.displayViewerCount,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "language".tr,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    DropdownButton(
                      value: supportedLanguages.firstWhereOrNull((element) =>
                              element['languageCode'] ==
                                  Get.locale!.languageCode &&
                              element['countryCode'] ==
                                  Get.locale!.countryCode) ??
                          supportedLanguages[0],
                      items: List.generate(
                        supportedLanguages.length,
                        (index) => DropdownMenuItem(
                          value: supportedLanguages[index],
                          child: Text(supportedLanguages[index]['name']!),
                        ),
                      ),
                      onChanged: (value) {
                        Locale locale = Locale(
                            value!['languageCode']!, value['countryCode']!);
                        Get.updateLocale(locale);

                        controller.homeViewController.settings.value =
                            controller.homeViewController.settings.value
                                .copyWith(
                          generalSettings: controller
                              .homeViewController.settings.value.generalSettings
                              ?.copyWith(appLanguage: {
                            "languageCode": value['languageCode']!,
                            "countryCode": value['countryCode']!
                          }),
                        );
                        controller.saveSettings();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget connectionsSettings(BuildContext context, double width) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "connections_tabs".tr,
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary, fontSize: 20),
          ),
          Container(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                settingsGoToRow(
                  context,
                  "manage_browser_tabs".tr,
                  Icons.list,
                  () {
                    Get.to(
                      () => ManageListBrowserTabs(
                        controller: controller,
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "OBS",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Switch(
                      onChanged: (value) {
                        controller.homeViewController.settings.value =
                            controller.homeViewController.settings.value
                                .copyWith(isObsConnected: value);
                        controller.saveSettings();
                      },
                      value: controller
                          .homeViewController.settings.value.isObsConnected!,
                    ),
                  ],
                ),
                Visibility(
                  visible: controller
                      .homeViewController.settings.value.isObsConnected!,
                  child: ObsSettings(
                    controller: controller,
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: Platform.isIOS ||
                      kDebugMode ||
                      storeController.storeFound.value &&
                          storeController.products.isNotEmpty,
                  child: StreamElements(controller: controller),
                ),
                const SizedBox(height: 10),
                RealtimeIrl(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget contactSettings(BuildContext context, double width) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact",
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary, fontSize: 20),
          ),
          Container(
            padding: const EdgeInsets.only(left: 4, right: 4, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    launchUrl(
                      Uri(
                        scheme: "https",
                        host: "irllink.com",
                      ),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Text(
                    'irllink.com',
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        launchUrl(
                          Uri(
                            scheme: "https",
                            host: "discord.gg",
                            path: "/irltools",
                          ),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: SvgPicture.asset(
                        './lib/assets/discord-mark-blue.svg',
                        semanticsLabel: 'discord icon',
                        width: 25,
                        height: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        launchUrl(
                          Uri(
                            scheme: "https",
                            host: "github.com",
                            path: "/LezdCS/irl_link",
                          ),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: SvgPicture.asset(
                        './lib/assets/icon-github.svg',
                        semanticsLabel: 'github icon',
                        width: 25,
                        height: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        launchUrl(
                          Uri(
                            scheme: "https",
                            host: "twitter.com",
                            path: "/LezdCS",
                          ),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: SvgPicture.asset(
                        './lib/assets/icon-twitter.svg',
                        semanticsLabel: 'twitter icon',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget settingsGoToRow(BuildContext context, String title, IconData icon,
      Function goToFunction) {
    return InkWell(
      onTap: () async {
        goToFunction();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).primaryIconTheme.color,
                  size: 22,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).primaryIconTheme.color,
            size: 18,
          ),
        ],
      ),
    );
  }
}
