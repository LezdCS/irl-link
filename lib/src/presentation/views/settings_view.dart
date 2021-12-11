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
      ),
    );
  }
}
