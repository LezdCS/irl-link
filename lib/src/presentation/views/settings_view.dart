import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:irllink/src/core/utils/globals.dart' as Globals;

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
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            onPressed: () => Get.back(),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 6, top: 10, bottom: 10),
              padding: EdgeInsets.only(left: 8, right: 8),
              child: TextButton(
                onPressed: () {
                  if (controller.twitchData != null) {
                    controller.logout();
                  } else {
                    controller.login();
                  }
                },
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 12),
                  backgroundColor: controller.twitchData != null
                      ? Colors.red
                      : Colors.purple,
                ),
                child: Text(
                  controller.twitchData != null ? "Logout" : "Login",
                  style: TextStyle(color: Colors.white),
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
            padding: EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 8),
            children: [
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
                padding: EdgeInsets.only(left: 4, right: 4, top: 6),
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
                            color: Theme.of(context).textTheme.bodyLarge!.color,
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
                                  Theme.of(context).textTheme.bodyLarge!.color,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Show message timestamp",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
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
                          "Join another streamer chat",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
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
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: TextFormField(
                              controller:
                                  controller.alternateChannelChatController,
                              onChanged: (value) {
                                controller.settings.value =
                                    controller.settings.value.copyWith(
                                        alternateChannelName: controller
                                            .alternateChannelChatController.text
                                            .toLowerCase()
                                            .trim());
                                controller.saveSettings();
                              },
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                enabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                hintText: 'Nickname',
                                labelText: 'Twitch username',
                                filled: false,
                                labelStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                                suffixIconConstraints: BoxConstraints(
                                  minWidth: 2,
                                  minHeight: 2,
                                ),
                                suffixIcon: controller
                                        .alternateChannelChatController
                                        .text
                                        .isNotEmpty
                                    ? IconButton(
                                        iconSize: 20,
                                        icon: Icon(
                                          Icons.clear,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color,
                                        ),
                                        onPressed: () {
                                          controller
                                              .alternateChannelChatController
                                              .clear();
                                          controller.settings.value = controller
                                              .settings.value
                                              .copyWith(
                                                  alternateChannelName: controller
                                                      .alternateChannelChatController
                                                      .text
                                                      .toLowerCase()
                                                      .trim());
                                          controller.saveSettings();
                                        },
                                      )
                                    : null,
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
                    padding: EdgeInsets.only(top: 10, bottom: 10),
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
                                  Theme.of(context).textTheme.bodyLarge!.color,
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
                            color: Theme.of(context).textTheme.bodyLarge!.color,
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
                          "Prevent speaker from sleeping",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
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
                                  Theme.of(context).textTheme.bodyLarge!.color,
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
                          color: Theme.of(context).textTheme.bodyLarge!.color,
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
                                onChanged: (value) {
                                  controller.settings.value = controller
                                      .settings.value
                                      .copyWith(obsWebsocketUrl: value);
                                  controller.saveSettings();
                                },
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 7),
                                  hintText: 'url',
                                  labelText: 'Websocket Url',
                                  labelStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        controller.obsWebsocketUrlShow.value
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                    color: Theme.of(context)
                                        .primaryIconTheme
                                        .color,
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
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller
                                    .obsWebsocketPasswordFieldController,
                                obscureText:
                                    !controller.obsWebsocketPasswordShow.value,
                                onChanged: (value) {
                                  controller.settings.value = controller
                                      .settings.value
                                      .copyWith(obsWebsocketPassword: value);
                                  controller.saveSettings();
                                },
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 7),
                                  hintText: 'password',
                                  labelText: 'Websocket Password',
                                  labelStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(controller
                                            .obsWebsocketPasswordShow.value
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    color: Theme.of(context)
                                        .primaryIconTheme
                                        .color,
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
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: TextStyle(fontSize: 12),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  fixedSize: Size(50, 20),
                                ),
                                onPressed: () {
                                  MobileScannerController cameraController =
                                      MobileScannerController();

                                  Get.dialog(_qrPasswordScanner(
                                      cameraController, controller, context));

                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Scan QR code',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.qr_code, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: TextStyle(fontSize: 12),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer,
                                  fixedSize: Size(50, 20),
                                ),
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: "History",
                                    cancelTextColor: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    textCancel: "Cancel",
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    content: _obsHistory(controller),
                                  );
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'History',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.history, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            launchUrlString(
                              "https://www.irllink.com/wiki/obs-websocket",
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.open_in_browser,
                                color: Colors.blue,
                              ),
                              Text(
                                "How can I get these parameters ?",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        )
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
                SizedBox(
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
                    SizedBox(
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

  Widget _qrPasswordScanner(MobileScannerController controllerCamera,
      SettingsViewController controller, BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 250,
      height: 250,
    );
    return Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(
          controller: controllerCamera,
          scanWindow: scanWindow,
          onDetect: (capture) {
            if (capture.barcodes.isEmpty) {
            } else {
              final String code = capture.barcodes.first.rawValue!;
              String password = code.split("/").last;
              String url = code.split("/")[2];
              controller.obsWebsocketPasswordFieldController.text = password;
              controller.obsWebsocketUrlFieldController.text = url;

              controller.settings.value =
                  controller.settings.value.copyWith(obsWebsocketUrl: url);

              controller.settings.value = controller.settings.value
                  .copyWith(obsWebsocketPassword: password);

              controller.saveSettings();
              Get.back();
            }
          },
        ),
        CustomPaint(
          painter: ScannerOverlay(scanWindow),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          bottom: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Close",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Scan your OBS QR code",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _obsHistory(SettingsViewController controller) {
    return Container(
      child: Container(
        height: 200,
        child: ListView.builder(
          itemCount: controller.settings.value.obsConnectionsHistory!.length,
          itemBuilder: (context, index) {
            String url =
                controller.settings.value.obsConnectionsHistory![index]['url']!;
            String password = controller
                .settings.value.obsConnectionsHistory![index]['password']!;

            return ListTile(
              title: Text(url),
              onTap: () {
                controller.obsWebsocketUrlFieldController.text = url;
                controller.obsWebsocketPasswordFieldController.text = password;
                controller.settings.value = controller.settings.value.copyWith(
                    obsWebsocketUrl: url, obsWebsocketPassword: password);
                controller.saveSettings();
                Get.back();
              },
            );
          },
        ),
      ),
    );
  }
}

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow);

  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()..addRect(scanWindow);

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
