import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:irllink/src/presentation/widgets/settings_view/chat_events.dart';
import 'package:irllink/src/presentation/widgets/settings_view/stream_elements.dart';
import 'package:irllink/src/presentation/widgets/settings_view/tts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:irllink/src/core/utils/globals.dart' as Globals;

import '../../core/resources/AppTranslations.dart';
import '../widgets/settings_view/chats_joined.dart';
import '../widgets/settings_view/manage_list_hidden_users.dart';
import '../widgets/settings_view/manage_list_browser_tabs.dart';
import '../widgets/settings_view/obs_settings.dart';
import '../widgets/settings_view/subscription.dart';

class SettingsView extends GetView<SettingsViewController> {
  final SettingsViewController controller = Get.find<SettingsViewController>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).textTheme.bodyLarge!.color,
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
                  textStyle: const TextStyle(fontSize: 12),
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
          title: Text(
            "Settings",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          centerTitle: false,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          child: ListView(
            padding:
                const EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 8),
            children: [
              Subscription(controller: controller),
              Divider(
                height: 20,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Theme.of(context).colorScheme.secondary,
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
              Divider(
                height: 20,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              generalSettings(context, width),
              Divider(
                height: 20,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              contactSettings(context, width),
              Container(
                padding: const EdgeInsets.only(left: 4, right: 4, top: 6),
                child: Text("Version: ${Globals.version}"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget chatSettings(BuildContext context, double width) {
    return Container(
      color: Theme.of(context).colorScheme.background,
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
                    Text(
                      "FFZ, BTTV & 7TV emotes",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
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
                      inactiveTrackColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                      activeTrackColor: Theme.of(context).colorScheme.tertiary,
                      activeColor: Colors.white,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "text_size".tr,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 18),
                    ),
                    Text(
                        controller.homeViewController.settings.value.textSize!
                            .ceil()
                            .toString(),
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 18)),
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
                      activeColor: Theme.of(context).colorScheme.tertiary,
                      inactiveColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
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
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 18),
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
                      inactiveTrackColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                      activeTrackColor: Theme.of(context).colorScheme.tertiary,
                      activeColor: Colors.white,
                    )
                  ],
                ),
                InkWell(
                  onTap: () async {
                    Get.to(
                      () => ChatsJoined(),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.wechat_sharp,
                              color: Theme.of(context).primaryIconTheme.color,
                              size: 22,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Chats joined",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
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
                ),
                InkWell(
                  onTap: () async {
                    Get.to(
                      () => ChatEvents(
                        controller: controller,
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.reviews,
                              color: Theme.of(context).primaryIconTheme.color,
                              size: 22,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Chat events",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
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
                ),
                InkWell(
                  onTap: () async {
                    Get.to(
                      () => ManageListHiddenUsers(
                        controller: controller,
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.list,
                              color: Theme.of(context).primaryIconTheme.color,
                              size: 22,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "manage_hidden_users".tr,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
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
                ),
                InkWell(
                  onTap: () async {
                    Get.to(
                      () => Tts(
                        controller: controller,
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.spatial_audio_off_rounded,
                              color: Theme.of(context).primaryIconTheme.color,
                              size: 22,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "text_to_speech".tr,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
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
      color: Theme.of(context).colorScheme.background,
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
                //Themes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "dark_mode".tr,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
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
                                .copyWith(isDarkMode: value);
                        controller.saveSettings();
                      },
                      value: controller
                          .homeViewController.settings.value.isDarkMode!,
                      activeTrackColor: Theme.of(context).colorScheme.tertiary,
                      activeColor: Colors.white,
                      inactiveTrackColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "prevent_speaker".tr,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Switch(
                      onChanged: (value) {
                        controller.homeViewController.settings.value =
                            controller.homeViewController.settings.value
                                .copyWith(keepSpeakerOn: value);
                        controller.saveSettings();
                      },
                      value: controller
                          .homeViewController.settings.value.keepSpeakerOn!,
                      activeTrackColor: Theme.of(context).colorScheme.tertiary,
                      activeColor: Colors.white,
                      inactiveTrackColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Display viewer count",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Switch(
                      onChanged: (value) {
                        controller.homeViewController.settings.value =
                            controller.homeViewController.settings.value
                                .copyWith(displayViewerCount: value);
                        controller.saveSettings();
                      },
                      value: controller.homeViewController.settings.value
                          .displayViewerCount!,
                      activeTrackColor: Theme.of(context).colorScheme.tertiary,
                      activeColor: Colors.white,
                      inactiveTrackColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "language".tr,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 18,
                      ),
                    ),
                    DropdownButton(
                        value: supportedLanguages.firstWhere((element) =>
                            element['languageCode'] ==
                                Get.locale!.languageCode &&
                            element['countryCode'] == Get.locale!.countryCode),
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
                                  .copyWith(appLanguage: {
                            "languageCode": value['languageCode']!,
                            "countryCode": value['countryCode']!
                          });
                          controller.saveSettings();
                        }),
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
      color: Theme.of(context).colorScheme.background,
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
                InkWell(
                  onTap: () {
                    Get.to(
                      () => ManageListBrowserTabs(
                        controller: controller,
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.list,
                              color: Theme.of(context).primaryIconTheme.color,
                              size: 22,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "manage_browser_tabs".tr,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "OBS",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
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
                      inactiveTrackColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                      activeTrackColor: Theme.of(context).colorScheme.tertiary,
                      activeColor: Colors.white,
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
                StreamElements(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget contactSettings(BuildContext context, double width) {
    return Container(
      color: Theme.of(context).colorScheme.background,
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
                InkWell(
                  onTap: () {
                    launchUrl(
                      Uri(scheme: "mailto", path: "support@irllink.com"),
                    );
                  },
                  child: Text(
                    'support@irllink.com',
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
}
