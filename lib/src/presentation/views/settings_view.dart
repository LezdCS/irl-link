import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/manage_list.dart';

class SettingsView extends GetView<SettingsViewController> {
  final SettingsViewController controller = Get.find<SettingsViewController>();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
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
            color: Theme.of(context).primaryColor,
          ),
          child: ListView(
            padding: EdgeInsets.only(top: 8, left: 18, right: 18, bottom: 8),
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
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Chat",
              style: TextStyle(color: Color(0xFF6441A5), fontSize: 22),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
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
                          inactiveTrackColor: Colors.grey,
                          activeTrackColor: Color(0xFF6441A5),
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
                          activeColor: Color(0xFF6441A5),
                          inactiveColor: Colors.grey,
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
                          activeColor: Color(0xFF6441A5),
                          inactiveColor: Colors.grey,
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
                          inactiveTrackColor: Colors.grey,
                          activeTrackColor: Color(0xFF6441A5),
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
                          inactiveTrackColor: Colors.grey,
                          activeTrackColor: Color(0xFF6441A5),
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
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
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
                              backgroundColor: Colors.deepPurpleAccent,
                              fixedSize: Size(50, 20),
                            ),
                            onPressed: () {
                              controller.settings.value =
                                  controller.settings.value.copyWith(
                                      alternateChannelName: controller
                                          .alternateChannelChatController.text);
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
                Container(
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
                        child: InkWell(
                          onTap: () {
                            Get.to(() => Obx(
                                  () => ManageList(
                                    title: "Manage hidden users",
                                    controller: controller,
                                    isReorderable: false,
                                    list: controller
                                        .settings.value.hiddenUsersIds!.obs,
                                    addFunction: () {},
                                    removeFunction: controller.removeHiddenUser,
                                    removeAllFunction:
                                        controller.clearHiddenUsers,
                                  ),
                                ));
                          },
                          child: Text(
                            "Manage hidden users",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: 18,
                            ),
                          ),
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

  Widget generalSettings(BuildContext context, double width) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "General",
              style: TextStyle(color: Color(0xFF6441A5), fontSize: 22),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
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
                          activeTrackColor: Color(0xFF6441A5),
                          activeColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
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
                          activeTrackColor: Color(0xFF6441A5),
                          activeColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
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
                          activeTrackColor: Color(0xFF6441A5),
                          activeColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
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
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Connections & Tabs",
              style: TextStyle(color: Color(0xFF6441A5), fontSize: 22),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Text(
                        "OBS",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Switch(
                        onChanged: (value) {
                          controller.settings.value = controller.settings.value
                              .copyWith(isObsConnected: value);
                          controller.saveSettings();
                        },
                        value: controller.settings.value.isObsConnected!,
                        inactiveTrackColor: Colors.grey,
                        activeTrackColor: Color(0xFF6441A5),
                        activeColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: controller.settings.value.isObsConnected!,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 7,
                          child: TextFormField(
                            controller:
                                controller.obsWebsocketUrlFieldController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'url:port',
                              labelText: 'Weboscket Url',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(fontSize: 12),
                              backgroundColor: Colors.deepPurpleAccent,
                              fixedSize: Size(50, 20),
                            ),
                            onPressed: () {
                              controller.settings.value =
                                  controller.settings.value.copyWith(
                                      obsWebsocketUrl: controller
                                          .obsWebsocketUrlFieldController.text);
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
                Container(
                  child: Text(
                    "Stream Elements",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
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
                            controller.settings.value
                                        .streamElementsAccessToken !=
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
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Contact",
              style: TextStyle(color: Color(0xFF6441A5), fontSize: 22),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    //TODO : https://pub.dev/packages/url_launcher config for android package visibility configuration (API > 30 )
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
                //todo : add Twitter icon
                //todo : add GitHub icon
              ],
            ),
          ),
        ],
      ),
    );
  }
}
