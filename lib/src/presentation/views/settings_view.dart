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
            color: Color(0xFF282828),
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
                  Get.to(() => appearanceSettings());
                },
                child: Text(
                  "Appearance",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => connectionsSettings());
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
                  Get.to(() => contact());
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
          color: Color(0xFF282828),
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
                              },
                              value: controller
                                  .isSwitchedForFFZAndBTTVEmotes.value,
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
                              min: 1.0,
                              max: 20.0,
                              divisions: null,
                              activeColor: Color(0xFF6441A5),
                              inactiveColor: Colors.grey,
                              label: 'Set text size value',
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
                              min: 1.0,
                              max: 20.0,
                              divisions: null,
                              activeColor: Color(0xFF6441A5),
                              inactiveColor: Colors.grey,
                              label: 'Set Emotes and Badges size',
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

  Widget appearanceSettings() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.black,
        title: Text("Appearance Settings"),
        centerTitle: false,
      ),
      body: Container(),
      backgroundColor: Color(0xFF282828),
    );
  }

  Widget connectionsSettings() {
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
      body: Container(),
      backgroundColor: Color(0xFF282828),
    );
  }

  Widget contact() {
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
      backgroundColor: Color(0xFF282828),
    );
  }
}
