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
                    width: 160,
                    child: Text(
                      "FFZ & BTTV emotes",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                      child: Switch(
                    onChanged: (value) {
                      controller.isSwitched.value = value;
                    },
                    value: controller.isSwitched.value,
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
