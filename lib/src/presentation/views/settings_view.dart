import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/manage_list_hidden_users.dart';
import '../widgets/manage_list_browser_tabs.dart';

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
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            onPressed: () => Get.back(),
          ),
          actions: [
            InkWell(
              onTap: () {
                controller.logout();
              },
              child: Container(
                margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                padding: EdgeInsets.only(left: 8, right: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text("Logout"),
              ),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            "Settings",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          centerTitle: false,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          child: ListView(
            padding: EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 8),
            children: [
              chatSettings(context, width),
              Divider(),
              connectionsSettings(context, width),
              Divider(),
              generalSettings(context, width),
              Divider(),
              contactSettings(context, width),
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
          Container(
            child: Text(
              "Chat",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary, fontSize: 22),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 4, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "FFZ, BTTV & 7TV emotes",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        child: Switch(
                          onChanged: (value) {
                            controller.settings.value = controller
                                .settings.value
                                .copyWith(isEmotes: value);
                            controller.saveSettings();
                          },
                          value: controller.settings.value.isEmotes!,
                          inactiveTrackColor:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          activeTrackColor:
                              Theme.of(context).colorScheme.tertiary,
                          activeColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Text size",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: 18),
                        ),
                      ),
                      Container(
                        child: Slider(
                          onChanged: (value) {
                            controller.settings.value = controller
                                .settings.value
                                .copyWith(textSize: value);
                            controller.saveSettings();
                          },
                          value: controller.settings.value.textSize!,
                          min: 0.0,
                          max: 50.0,
                          divisions: 100,
                          activeColor: Theme.of(context).colorScheme.tertiary,
                          inactiveColor:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          label: "${controller.settings.value.textSize}",
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Badges & emotes size",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: 18),
                        ),
                      ),
                      Container(
                        child: Slider(
                          onChanged: (value) {
                            controller.settings.value = controller
                                .settings.value
                                .copyWith(emotesSize: value);
                            controller.saveSettings();
                          },
                          value: controller.settings.value.emotesSize!,
                          min: 0.0,
                          max: 50.0,
                          divisions: 100,
                          activeColor: Theme.of(context).colorScheme.tertiary,
                          inactiveColor:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          label: '${controller.settings.value.emotesSize}',
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Show message timestamp",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: 18),
                        ),
                      ),
                      Container(
                        child: Switch(
                          onChanged: (value) {
                            controller.settings.value = controller
                                .settings.value
                                .copyWith(displayTimestamp: value);
                            controller.saveSettings();
                          },
                          value: controller.settings.value.displayTimestamp!,
                          inactiveTrackColor:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          activeTrackColor:
                              Theme.of(context).colorScheme.tertiary,
                          activeColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Join alternate channel chat",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: 18),
                        ),
                      ),
                      Container(
                        child: Switch(
                          onChanged: (value) {
                            controller.settings.value = controller
                                .settings.value
                                .copyWith(alternateChannel: value);
                            if (!value) {
                              controller.settings.value = controller
                                  .settings.value
                                  .copyWith(alternateChannelName: '');
                              controller.alternateChannelChatController.text =
                                  '';
                            }
                            controller.saveSettings();
                          },
                          value: controller.settings.value.alternateChannel!,
                          inactiveTrackColor:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          activeTrackColor:
                              Theme.of(context).colorScheme.tertiary,
                          activeColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: controller.settings.value.alternateChannel!,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: TextFormField(
                            controller:
                                controller.alternateChannelChatController,
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              border: InputBorder.none,
                              hintText: 'Nickname',
                              labelText: 'Twitch nickname',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(fontSize: 12),
                              backgroundColor:
                                  Theme.of(context).colorScheme.tertiary,
                              fixedSize: Size(50, 20),
                            ),
                            onPressed: () {
                              controller.settings.value =
                                  controller.settings.value.copyWith(
                                      alternateChannelName: controller
                                          .alternateChannelChatController.text
                                          .toLowerCase());
                              controller.saveSettings();
                              SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                  child: Container(
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.list,
                          color: Theme.of(context).primaryIconTheme.color,
                          size: 22,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Manage hidden users",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
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
          Container(
            child: Text(
              "General",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary, fontSize: 22),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 4, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Themes
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Dark mode",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        child: Switch(
                          onChanged: (value) {
                            value
                                ? Get.changeThemeMode(ThemeMode.dark)
                                : Get.changeThemeMode(ThemeMode.light);
                            controller.settings.value = controller
                                .settings.value
                                .copyWith(isDarkMode: value);
                            controller.saveSettings();
                          },
                          value: controller.settings.value.isDarkMode!,
                          activeTrackColor:
                              Theme.of(context).colorScheme.tertiary,
                          activeColor: Colors.white,
                          inactiveTrackColor:
                              Theme.of(context).colorScheme.tertiaryContainer,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Keep speaker on",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        child: Switch(
                          onChanged: (value) {
                            controller.settings.value = controller
                                .settings.value
                                .copyWith(keepSpeakerOn: value);
                            controller.saveSettings();
                          },
                          value: controller.settings.value.keepSpeakerOn!,
                          activeTrackColor:
                              Theme.of(context).colorScheme.tertiary,
                          activeColor: Colors.white,
                          inactiveTrackColor:
                              Theme.of(context).colorScheme.tertiaryContainer,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Keep screen on",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        child: Switch(
                          onChanged: (value) {
                            controller.settings.value = controller
                                .settings.value
                                .copyWith(keepScreenOn: value);
                            controller.saveSettings();
                          },
                          value: controller.settings.value.keepScreenOn!,
                          activeTrackColor:
                              Theme.of(context).colorScheme.tertiary,
                          activeColor: Colors.white,
                          inactiveTrackColor:
                              Theme.of(context).colorScheme.tertiaryContainer,
                        ),
                      )
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

  Widget connectionsSettings(BuildContext context, double width) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Connections & Tabs",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary, fontSize: 22),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 4, right: 4),
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
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.list,
                          color: Theme.of(context).primaryIconTheme.color,
                          size: 22,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Manage browser tabs",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "OBS",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      child: Switch(
                        onChanged: (value) {
                          controller.settings.value = controller.settings.value
                              .copyWith(isObsConnected: value);
                          controller.saveSettings();
                        },
                        value: controller.settings.value.isObsConnected!,
                        inactiveTrackColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                        activeTrackColor:
                            Theme.of(context).colorScheme.tertiary,
                        activeColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: controller.settings.value.isObsConnected!,
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 7,
                              child: TextFormField(
                                controller:
                                    controller.obsWebsocketUrlFieldController,
                                obscureText:
                                    !controller.obsWebsocketUrlShow.value,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                  border: InputBorder.none,
                                  hintText: 'url',
                                  labelText: 'Weboscket Url',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        controller.obsWebsocketUrlShow.value
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                    onPressed: () {
                                      controller.obsWebsocketUrlShow.value =
                                          !controller.obsWebsocketUrlShow.value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 7,
                              child: TextFormField(
                                controller: controller
                                    .obsWebsocketPasswordFieldController,
                                obscureText:
                                    !controller.obsWebsocketPasswordShow.value,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                  border: InputBorder.none,
                                  hintText: 'password',
                                  labelText: 'Weboscket Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        controller.obsWebsocketUrlShow.value
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                    onPressed: () {
                                      controller
                                              .obsWebsocketPasswordShow.value =
                                          !controller
                                              .obsWebsocketPasswordShow.value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: TextStyle(fontSize: 12),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  fixedSize: Size(50, 20),
                                ),
                                onPressed: () {
                                  controller.settings.value =
                                      controller.settings.value.copyWith(
                                    obsWebsocketUrl: controller
                                        .obsWebsocketUrlFieldController.text,
                                    obsWebsocketPassword: controller
                                        .obsWebsocketPasswordFieldController
                                        .text,
                                  );
                                  controller.saveSettings();
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Container(
                        child: Text(
                          "Stream Elements",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(fontSize: 12),
                          backgroundColor: controller.settings.value
                                      .streamElementsAccessToken !=
                                  ""
                              ? Colors.redAccent
                              : Colors.green,
                          fixedSize: Size(50, 20),
                        ),
                        onPressed: () {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        },
                        child: Text(
                          controller.settings.value.streamElementsAccessToken !=
                                  ""
                              ? 'Logout'
                              : 'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
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

  Widget contactSettings(BuildContext context, double width) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Contact",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary, fontSize: 22),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 4, right: 4, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    launch("https://irllink.com");
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
                    launch("mailto:support@irllink.com");
                  },
                  child: Text(
                    'support@irllink.com',
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        launch("https://github.com/LezdCS/irl_link");
                      },
                      child: SvgPicture.asset(
                        './lib/assets/icon-github.svg',
                        semanticsLabel: 'github icon',
                        width: 25,
                        height: 25,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        launch("https://twitter.com/LezdCS");
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
