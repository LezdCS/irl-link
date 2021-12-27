import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';

class SettingsView extends GetView<SettingsViewController> {
  final SettingsViewController controller = Get.find<SettingsViewController>();
  @override
  Widget build(BuildContext context) {
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
                  Get.to(() => chatSettings());
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

  Widget chatSettings() {
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
        body: Obx(() => Container(
            width: double.infinity,
            color: Color(0xFF282828),
            child: Column(
              children: [
                //FFZ et BTTV
                Container(
                    child: Row(children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "FFZ & BTTV emotes :",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(165, 0, 0, 0),
                      child: Switch(
                        onChanged: (value) {
                          controller.isSwitchedForFFZAndBTTVEmotes.value =
                              value;
                        },
                        value: controller.isSwitchedForFFZAndBTTVEmotes.value,
                        activeTrackColor: Colors.purpleAccent,
                        activeColor: Colors.white,
                      ))
                ])),

                //TextSize
                Container(
                    child: Row(children: [
                  //"text"
                  Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "Text size :",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.left,
                      )),
                  //slider
                  Container(
                    padding: const EdgeInsets.fromLTRB(126, 0, 0, 0),
                    child: Slider(
                      onChanged: (value) {
                        controller.slideValueForTextSize.value = value;
                      },
                      value: controller.slideValueForTextSize.value,
                      min: 1.0,
                      max: 20.0,
                      divisions: 10,
                      activeColor: Colors.purpleAccent,
                      inactiveColor: Colors.purple,
                      label: 'Set text size value',
                    ),
                  )
                ])),

                //Emotes and badges Size
                Container(
                    child: Row(children: [
                  //"text"
                  Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "Badges and emotes size :",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.left,
                      )),
                  //slider
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Slider(
                      onChanged: (value) {
                        controller.slideValueForBadgesAndEmotesSize.value =
                            value;
                      },
                      value: controller.slideValueForBadgesAndEmotesSize.value,
                      min: 1.0,
                      max: 20.0,
                      divisions: 10,
                      activeColor: Colors.purpleAccent,
                      inactiveColor: Colors.purple,
                      label: 'Set text size value',
                    ),
                  )
                ])),

                //Show message timestamp
                Container(
                    child: Row(children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "Show message timestamp :",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(115, 0, 0, 0),
                      child: Switch(
                        onChanged: (value) {
                          controller.isSwitchedForTimestamp.value = value;
                        },
                        value: controller.isSwitchedForTimestamp.value,
                        activeTrackColor: Colors.purpleAccent,
                        activeColor: Colors.white,
                      ))
                ])),

                //Join alternate channel chat
                Container(
                    child: Row(children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "Join alternante channel chat :",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(101, 0, 0, 0),
                      child: Switch(
                        onChanged: (value) {
                          controller.isSwitchedForAlternateChannel.value =
                              value;
                        },
                        value: controller.isSwitchedForAlternateChannel.value,
                        activeTrackColor: Colors.purpleAccent,
                        activeColor: Colors.white,
                      ))
                ])),
              ],
            ))));
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
