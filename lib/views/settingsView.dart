import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/Controller/SettingsViewController.dart';

class SettingsView extends GetView<SettingsViewController> {
  final SettingsViewController controller = Get.put(SettingsViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.black,
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Container(
        child: InkWell(
          onTap: () {
            controller.logout();
          },
          child: Text("logout"),
        ),
      ),
    );
  }
}
