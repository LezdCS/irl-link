import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';

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
                                controller.isSwitchedForFFZAndBTTVEmotes.value =
                                    value;
                                controller.settings = controller.settings
                                    .copyWith(isEmotes: value);
                                controller.saveSettings();
                              },
                              value: controller
                                  .isSwitchedForFFZAndBTTVEmotes.value,
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
                                controller.slideValueForTextSize.value = value;
                              },
                              value: controller.slideValueForTextSize.value,
                              min: 0.0,
                              max: 50.0,
                              divisions: 100,
                              activeColor: Color(0xFF6441A5),
                              inactiveColor: Colors.grey,
                              label: "${controller.slideValueForTextSize.value}",
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
                                controller.slideValueForBadgesAndEmotesSize
                                    .value = value;
                              },
                              value: controller
                                  .slideValueForBadgesAndEmotesSize.value,
                              min: 0.0,
                              max: 50.0,
                              divisions: 100,
                              activeColor: Color(0xFF6441A5),
                              inactiveColor: Colors.grey,
                              label: '${controller
                                  .slideValueForBadgesAndEmotesSize.value}',
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
                                controller.isSwitchedForTimestamp.value = value;
                              },
                              value: controller.isSwitchedForTimestamp.value,
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
                                controller.isSwitchedForAlternateChannel.value =
                                    value;
                              },
                              value: controller
                                  .isSwitchedForAlternateChannel.value,
                              inactiveTrackColor: Colors.grey,
                              activeTrackColor: Color(0xFF6441A5),
                              activeColor: Colors.white,
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
                        child: Text(
                      "Themes",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Mode dark/light",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          Container(
                            child: Switch(
                              onChanged: (value) {
                                controller.isSwitchedForFFZAndBTTVEmotes.value =
                                    value;
                                controller.settings = controller.settings
                                    .copyWith(isEmotes: value);
                                controller.saveSettings();
                              },
                              value: controller
                                  .isSwitchedForFFZAndBTTVEmotes.value,
                              activeTrackColor: Color(0xFF6441A5),
                              activeColor: Colors.white,
                              inactiveTrackColor: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),

                    Container(
                        child: Text(
                      "Waking",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
                    //keep audio speaker awake
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "keep audio speaker awake",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          Container(
                            child: Switch(
                              onChanged: (value) {
                                controller.isSwitchedForTimestamp.value = value;
                              },
                              value: controller.isSwitchedForTimestamp.value,
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
                              "keep screen awake",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          Container(
                            child: Switch(
                              onChanged: (value) {
                                controller.isSwitchedForAlternateChannel.value =
                                    value;
                              },
                              value: controller
                                  .isSwitchedForAlternateChannel.value,
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
      body: Container(
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
                  //twitch
                  Container(
                      child: Text(
                    "Twitch",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "nickname",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              controller.logout();
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 10, top: 10, bottom: 10),
                              padding: EdgeInsets.only(left: 8, right: 8),
                              alignment: Alignment.center,
                              decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text("Logout"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  //streamElements
                  Container(
                      child: Text(
                    "Stream Elements",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "nickname",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              controller.logout();
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 10, top: 10, bottom: 10),
                              padding: EdgeInsets.only(left: 8, right: 8),
                              alignment: Alignment.center,
                              decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text("Logout"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  //OBS
                  Container(
                      child: Text(
                    "OBS",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Websocket URL",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              controller.logout();
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 10, top: 10, bottom: 10),
                              padding: EdgeInsets.only(left: 8, right: 8),
                              alignment: Alignment.center,
                              decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text("Logout"),
                            ),
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
