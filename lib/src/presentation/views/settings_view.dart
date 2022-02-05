import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:flutter/services.dart';

class SettingsView extends GetView<SettingsViewController> {
  final SettingsViewController controller = Get.find<SettingsViewController>();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
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
              decoration: new BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text("Logout"),
            ),
          ),
        ],
        backgroundColor: Colors.black,
        title: Text("Settings"),
        centerTitle: false,
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              InkWell(
                onTap: () {
                  Get.to(() => chatSettings(width));
                },
                child: Text(
                  "Chat",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => generalSettings(width));
                },
                child: Text(
                  "General",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => connectionsSettings(width));
                },
                child: Text(
                  "Connections",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => contactSettings());
                },
                child: Text(
                  "Contact",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ],
          )),
    );
  }

  Widget chatSettings(double width) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.black,
        title: Text("Chat Settings"),
        centerTitle: false,
      ),
      body: Obx(
        () => Container(
          padding: EdgeInsets.only(top: 20),
          width: width,
          color: Theme.of(Get.context!).colorScheme.secondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Chat",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //FFZ et BTTV
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "FFZ & BTTV emotes",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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

                    //TextSize
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //"text"
                          Container(
                            child: Text(
                              "Text size",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          //slider
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

                    //Emotes and badges Size
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //"text"
                          Container(
                            child: Text(
                              "Badges & emotes size",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          //slider
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

                    //Show message timestamp
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Show message timestamp",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
                              value:
                                  controller.settings.value.displayTimestamp!,
                              inactiveTrackColor: Colors.grey,
                              activeTrackColor: Color(0xFF6441A5),
                              activeColor: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),

                    //Join alternate channel chat
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Join alternate channel chat",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
                                  controller
                                      .alternateChannelChatController.text = '';
                                }
                                controller.saveSettings();
                              },
                              value:
                                  controller.settings.value.alternateChannel!,
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
                                            .alternateChannelChatController
                                            .text);
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
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget generalSettings(double width) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.black,
        title: Text("General Settings"),
        centerTitle: false,
      ),
      body: Obx(
        () => Container(
          padding: EdgeInsets.only(top: 20),
          width: width,
          color: Theme.of(Get.context!).colorScheme.secondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "General",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          Container(
                            child: Switch(
                              onChanged: (value) {
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

                    //keep audio speaker awake
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Keep audio speaker on",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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

                    //keep screen awake
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Keep screen on",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
        ),
      ),
    );
  }

  Widget connectionsSettings(double width) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.black,
        title: Text("Connections Settings"),
        centerTitle: false,
      ),
      body: Obx(
        () => Container(
          padding: EdgeInsets.only(top: 20),
          width: width,
          color: Theme.of(Get.context!).colorScheme.secondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Connections",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //streamElements
                    Container(
                        child: Text(
                      "Stream Elements",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
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

                    //OBS
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Text(
                            "OBS",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Switch(
                            onChanged: (value) {
                              controller.settings.value = controller
                                  .settings.value
                                  .copyWith(isObsConnected: value);
                              if (!value) {
                                controller.obsWebsocketUrlFieldController.text =
                                    '';
                                controller.settings.value = controller
                                    .settings.value
                                    .copyWith(obsWebsocketUrl: '');
                                controller.saveSettings();
                              }
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
                                  hintText: 'wss://url:port',
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
                                              .obsWebsocketUrlFieldController
                                              .text);
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contactSettings() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.black,
        title: Text("Contact"),
        centerTitle: false,
      ),
      body: Container(),
      backgroundColor: Theme.of(Get.context!).colorScheme.secondary,
    );
  }
}
