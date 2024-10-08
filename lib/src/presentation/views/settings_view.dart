import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/resources/app_translations.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation//widgets/settings/chats_joined.dart';
import 'package:irllink/src/presentation//widgets/settings/manage_list_browser_tabs.dart';
import 'package:irllink/src/presentation//widgets/settings/manage_list_hidden_users.dart';
import 'package:irllink/src/presentation//widgets/settings/obs_settings.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:irllink/src/presentation/widgets/settings/chat_events.dart';
import 'package:irllink/src/presentation/widgets/settings/dashboard_settings_view.dart';
import 'package:irllink/src/presentation/widgets/settings/realtime_irl.dart';
import 'package:irllink/src/presentation/widgets/settings/stream_elements.dart';
import 'package:irllink/src/presentation/widgets/settings/subscription.dart';
import 'package:irllink/src/presentation/widgets/settings/talker_screen.dart';
import 'package:irllink/src/presentation/widgets/settings/tts.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends GetView<SettingsViewController> {
  const SettingsView({super.key});

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
                      ? "logout".tr
                      : "login".tr,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
          title: Text(
            "settings".tr,
          ),
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
    Settings settings = Get.find<SettingsService>().settings.value;
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "chat".tr,
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
                        Get.find<SettingsService>().settings.value =
                            settings.copyWith(isEmotes: value);
                        Get.find<SettingsService>().saveSettings();
                      },
                      value: settings.isEmotes!,
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
                    Text(settings.textSize!.ceil().toString(),
                        style: const TextStyle(fontSize: 18)),
                    Slider(
                      onChanged: (value) {
                        Get.find<SettingsService>().settings.value =
                            settings.copyWith(textSize: value);
                        Get.find<SettingsService>().saveSettings();
                      },
                      value: settings.textSize!,
                      min: 0.0,
                      max: 50.0,
                      divisions: 100,
                      label: "${settings.textSize}",
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
                        Get.find<SettingsService>().settings.value =
                            settings.copyWith(displayTimestamp: value);
                        Get.find<SettingsService>().saveSettings();
                      },
                      value: settings.displayTimestamp!,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "hide_deleted_messages".tr,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Switch(
                      onChanged: (value) {
                        Get.find<SettingsService>().settings.value =
                            settings.copyWith(
                                chatSettings: settings.chatSettings
                                    ?.copyWith(hideDeletedMessages: value));

                        Get.find<SettingsService>().saveSettings();
                      },
                      value: settings.chatSettings!.hideDeletedMessages,
                    )
                  ],
                ),
                settingsGoToRow(
                  context,
                  "chats_joined".tr,
                  Icons.wechat_sharp,
                  () {
                    Get.to(
                      () => const ChatsJoined(),
                    );
                  },
                ),
                settingsGoToRow(
                  context,
                  "chat_events".tr,
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
                      () => const ManageListHiddenUsers(),
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
    Settings settings = Get.find<SettingsService>().settings.value;

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "general".tr,
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
                  "dashboard".tr,
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
                        Get.find<SettingsService>().settings.value =
                            settings.copyWith(
                          generalSettings: settings.generalSettings
                              ?.copyWith(isDarkMode: value),
                        );
                        Get.find<SettingsService>().saveSettings();
                      },
                      value: settings.generalSettings!.isDarkMode,
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
                        Get.find<SettingsService>().settings.value =
                            settings.copyWith(
                          generalSettings: settings.generalSettings
                              ?.copyWith(keepSpeakerOn: value),
                        );
                        Get.find<SettingsService>().saveSettings();
                      },
                      value: settings.generalSettings!.keepSpeakerOn,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "display_viewer_count".tr,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Switch(
                      onChanged: (value) {
                        Get.find<SettingsService>().settings.value =
                            settings.copyWith(
                          generalSettings: settings.generalSettings
                              ?.copyWith(displayViewerCount: value),
                        );
                        Get.find<SettingsService>().saveSettings();
                      },
                      value: settings.generalSettings!.displayViewerCount,
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

                        Get.find<SettingsService>().settings.value =
                            settings.copyWith(
                          generalSettings: settings.generalSettings?.copyWith(
                              appLanguage: {
                                "languageCode": value['languageCode']!,
                                "countryCode": value['countryCode']!
                              }),
                        );
                        Get.find<SettingsService>().saveSettings();
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
    Settings settings = Get.find<SettingsService>().settings.value;

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
                      () => const ManageListBrowserTabs(),
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
                        Get.find<SettingsService>().settings.value =
                            settings.copyWith(isObsConnected: value);
                        Get.find<SettingsService>().saveSettings();
                      },
                      value: settings.isObsConnected!,
                    ),
                  ],
                ),
                Visibility(
                  visible: settings.isObsConnected!,
                  child: ObsSettings(
                    controller: controller,
                  ),
                ),
                const SizedBox(height: 10),
                const StreamElements(),
                const SizedBox(height: 10),
                const RealtimeIrl(),
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
            "contact".tr,
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
