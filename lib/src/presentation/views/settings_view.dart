import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/core/resources/app_translations.dart';
import 'package:irllink/src/core/services/app_info_service.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:irllink/src/presentation/views/settings/chat_events.dart';
import 'package:irllink/src/presentation/views/settings/dashboard_settings_view.dart';
import 'package:irllink/src/presentation/views/settings/obs_settings.dart';
import 'package:irllink/src/presentation/views/settings/realtime_irl.dart';
import 'package:irllink/src/presentation/views/settings/subscription.dart';
import 'package:irllink/src/presentation/views/settings/talker_screen.dart';
import 'package:irllink/src/presentation/views/settings/tts.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends GetView<SettingsViewController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final settingsService = Get.find<SettingsService>();
    final settings = settingsService.settings;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Get.back(),
          ),
          title: Text(
            "settings".tr,
          ),
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: ListView(
            padding:
                const EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 8),
            children: [
              twitchProfileSettings(context, width),
              kickProfileSettings(context, width),
              const Subscription(),
              const Divider(
                height: 20,
              ),
              chatSettings(context, width, settingsService, settings),
              Divider(
                height: 20,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              connectionsSettings(context, width, settingsService, settings),
              const Divider(
                height: 20,
              ),
              generalSettings(context, width, settingsService, settings),
              const Divider(
                height: 20,
              ),
              contactSettings(context, width),
              Container(
                padding: const EdgeInsets.only(left: 4, right: 4, top: 6),
                child: Text("Version: ${Get.find<AppInfoService>().version}"),
              ),
              settingsGoToRow(
                context,
                'Logs',
                Icons.list_alt,
                () {
                  Get.to(
                    () => TalkerScreenView(
                      talker: Get.find<TalkerService>().talker,
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

  Widget chatSettings(
    BuildContext context,
    double width,
    SettingsService settingsService,
    Rx<Settings> settings,
  ) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "chat".tr,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 20,
            ),
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
                        settingsService.settings.value =
                            settings.value.copyWith(isEmotes: value);
                        settingsService.saveSettings();
                      },
                      value: settings.value.isEmotes,
                    ),
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
                      settings.value.textSize.ceil().toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                    Slider(
                      onChanged: (value) {
                        settingsService.settings.value =
                            settings.value.copyWith(textSize: value);
                        settingsService.saveSettings();
                      },
                      value: settings.value.textSize,
                      max: 50,
                      divisions: 100,
                      label: "${settings.value.textSize}",
                    ),
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
                        settingsService.settings.value =
                            settings.value.copyWith(displayTimestamp: value);
                        settingsService.saveSettings();
                      },
                      value: settings.value.displayTimestamp,
                    ),
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
                        settingsService.settings.value =
                            settings.value.copyWith(
                          chatSettings: settings.value.chatSettings
                              .copyWith(hideDeletedMessages: value),
                        );

                        settingsService.saveSettings();
                      },
                      value: settings.value.chatSettings.hideDeletedMessages,
                    ),
                  ],
                ),
                settingsGoToRow(
                  context,
                  "chats_joined".tr,
                  Icons.wechat_sharp,
                  () {
                    Get.toNamed(Routes.chatsSettings);
                  },
                ),
                settingsGoToRow(
                  context,
                  "chat_events".tr,
                  Icons.reviews,
                  () {
                    Get.to(
                      () => const ChatEvents(),
                    );
                  },
                ),
                settingsGoToRow(
                  context,
                  "manage_hidden_users".tr,
                  Icons.list,
                  () {
                    Get.toNamed(Routes.hiddenUsersSettings);
                  },
                ),
                settingsGoToRow(
                  context,
                  "text_to_speech".tr,
                  Icons.spatial_audio_off_rounded,
                  () {
                    Get.to(
                      () => const Tts(),
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

  Widget generalSettings(
    BuildContext context,
    double width,
    SettingsService settingsService,
    Rx<Settings> settings,
  ) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "general".tr,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 20,
            ),
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
                        settingsService.settings.value =
                            settings.value.copyWith(
                          generalSettings: settings.value.generalSettings
                              .copyWith(isDarkMode: value),
                        );
                        settingsService.saveSettings();
                        Get.changeThemeMode(
                          value ? ThemeMode.dark : ThemeMode.light,
                        );
                      },
                      value: settings.value.generalSettings.isDarkMode,
                    ),
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
                        Get.find<SettingsViewController>()
                            .updateKeepSpeakerOn(value: value);
                      },
                      value: settings.value.generalSettings.keepSpeakerOn,
                    ),
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
                        settingsService.settings.value =
                            settings.value.copyWith(
                          generalSettings: settings.value.generalSettings
                              .copyWith(displayViewerCount: value),
                        );
                        settingsService.saveSettings();
                      },
                      value: settings.value.generalSettings.displayViewerCount,
                    ),
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
                      value: supportedLanguages.firstWhereOrNull(
                            (element) =>
                                element['languageCode'] ==
                                    Get.locale!.languageCode &&
                                element['countryCode'] ==
                                    Get.locale!.countryCode,
                          ) ??
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
                          value!['languageCode']!,
                          value['countryCode'],
                        );
                        Get.updateLocale(locale);

                        settingsService.settings.value =
                            settings.value.copyWith(
                          generalSettings:
                              settings.value.generalSettings.copyWith(
                            appLanguage: {
                              "languageCode": value['languageCode'],
                              "countryCode": value['countryCode'],
                            },
                          ),
                        );
                        settingsService.saveSettings();
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

  Widget connectionsSettings(
    BuildContext context,
    double width,
    SettingsService settingsService,
    Rx<Settings> settings,
  ) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "connections_tabs".tr,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 20,
            ),
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
                    Get.toNamed(
                      Routes.browserSettings,
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
                        settingsService.settings.value =
                            settings.value.copyWith(isObsConnected: value);
                        settingsService.saveSettings();
                      },
                      value: settings.value.isObsConnected,
                    ),
                  ],
                ),
                Visibility(
                  visible: settings.value.isObsConnected,
                  child: const ObsSettings(),
                ),
                const SizedBox(height: 10),
                settingsGoToRow(
                  context,
                  "StreamElements",
                  Icons.rocket,
                  () {
                    Get.toNamed(Routes.streamelementsSettings);
                  },
                ),
                const SizedBox(height: 10),
                const RealtimeIrl(),
              ],
            ),
          ),
          settingsGoToRow(
            context,
            "RTMP",
            Icons.camera,
            () {
              Get.toNamed(
                Routes.rtmpSettings,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget contactSettings(BuildContext context, double width) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "contact".tr,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 20,
            ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget settingsGoToRow(
    BuildContext context,
    String title,
    IconData icon,
    Function goToFunction,
  ) {
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

  Widget twitchProfileSettings(BuildContext context, double width) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Twitch Profile",
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 20,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (controller.homeViewController.twitchData.value !=
                          null)
                        Row(
                          spacing: 15,
                          children: [
                            CachedNetworkImage(
                              imageUrl: controller.homeViewController.twitchData
                                  .value!.twitchUser.profileImageUrl,
                              placeholder: (BuildContext context, String url) =>
                                  const CircularProgressIndicator(),
                              errorWidget:
                                  (BuildContext context, String url, error) =>
                                      const Icon(Icons.error),
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                radius: 24,
                                backgroundImage: imageProvider,
                              ),
                            ),
                            Text(
                              controller.homeViewController.twitchData.value!
                                  .twitchUser.displayName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      else
                        const Text(
                          "Not logged in",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      TextButton(
                        onPressed: () {
                          if (controller.homeViewController.twitchData.value !=
                              null) {
                            controller.logout();
                          } else {
                            controller.login();
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              controller.homeViewController.twitchData.value !=
                                      null
                                  ? Colors.red
                                  : Colors.purple,
                          minimumSize: const Size(100, 40),
                        ),
                        child: Text(
                          controller.homeViewController.twitchData.value != null
                              ? "logout".tr
                              : "login".tr,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget kickProfileSettings(BuildContext context, double width) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kick Profile",
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 20,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (controller.homeViewController.kickData.value != null)
                        Row(
                          spacing: 15,
                          children: [
                            CachedNetworkImage(
                              imageUrl: controller.homeViewController.kickData
                                  .value!.kickUser.profilePicture,
                              placeholder: (BuildContext context, String url) =>
                                  const CircularProgressIndicator(),
                              errorWidget:
                                  (BuildContext context, String url, error) =>
                                      const Icon(Icons.error),
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                radius: 24,
                                backgroundImage: imageProvider,
                              ),
                            ),
                            Text(
                              controller.homeViewController.kickData.value!
                                  .kickUser.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      else
                        const Text(
                          "Not logged in",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      TextButton(
                        onPressed: () {
                          if (controller.homeViewController.kickData.value !=
                              null) {
                            controller.logoutKick();
                          } else {
                            controller.loginKick();
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              controller.homeViewController.kickData.value !=
                                      null
                                  ? Colors.red
                                  : Colors.purple,
                          minimumSize: const Size(100, 40),
                        ),
                        child: Text(
                          controller.homeViewController.kickData.value != null
                              ? "logout".tr
                              : "login".tr,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
