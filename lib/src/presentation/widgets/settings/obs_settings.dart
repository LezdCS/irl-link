import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ObsSettings extends StatelessWidget {
  final SettingsViewController controller;

  const ObsSettings({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final SettingsService settingsService = Get.find<SettingsService>();
    Settings settings = settingsService.settings.value;

    return Obx(
      () => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 7,
                  child: TextFormField(
                    controller: controller.obsWebsocketUrlFieldController,
                    obscureText: !controller.obsWebsocketUrlShow.value,
                    onChanged: (value) {
                      settingsService.settings.value =
                          settings.copyWith(obsWebsocketUrl: value);
                      settingsService.saveSettings();
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 7),
                      hintText: 'url',
                      labelText: 'Websocket Url',
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(controller.obsWebsocketUrlShow.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: Theme.of(context).primaryIconTheme.color,
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.obsWebsocketPasswordFieldController,
                    obscureText: !controller.obsWebsocketPasswordShow.value,
                    onChanged: (value) {
                      settingsService.settings.value =
                          settings.copyWith(obsWebsocketPassword: value);
                      settingsService.saveSettings();
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 7),
                      hintText: 'password',
                      labelText: 'Websocket Password',
                      suffixIcon: IconButton(
                        icon: Icon(controller.obsWebsocketPasswordShow.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: Theme.of(context).primaryIconTheme.color,
                        onPressed: () {
                          controller.obsWebsocketPasswordShow.value =
                              !controller.obsWebsocketPasswordShow.value;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      fixedSize: const Size(50, 20),
                    ),
                    onPressed: () {
                      MobileScannerController cameraController =
                          MobileScannerController();
                      Get.dialog(
                        _qrPasswordScanner(
                          cameraController,
                          controller,
                          context,
                        ),
                      );
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'scan_qr'.tr,
                        ),
                        const SizedBox(width: 5),
                        const Icon(Icons.qr_code, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                      fixedSize: const Size(50, 20),
                    ),
                    onPressed: () {
                      Get.defaultDialog(
                        title: "history".tr,
                        cancelTextColor:
                            Theme.of(context).textTheme.bodyLarge!.color,
                        textCancel: "cancel".tr,
                        backgroundColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                        content: _obsHistory(controller),
                      );
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'history'.tr,
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.history, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            InkWell(
              onTap: () {
                launchUrlString(
                  "https://www.irllink.com/blog/setup-obs-websocket",
                  mode: LaunchMode.externalApplication,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.open_in_browser,
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "how_can_i".tr,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _qrPasswordScanner(
    MobileScannerController controllerCamera,
    SettingsViewController controller,
    BuildContext context,
  ) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 250,
      height: 250,
    );
    final SettingsService settingsService = Get.find<SettingsService>();
    Settings settings = settingsService.settings.value;

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

              settingsService.settings.value =
                  settings.copyWith(obsWebsocketUrl: url);

              settingsService.settings.value =
                  settings.copyWith(obsWebsocketPassword: password);

              settingsService.saveSettings();
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
              SizedBox(
                width: 100,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "close".tr,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
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
                "scan_qr_code".tr,
                style: const TextStyle(
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
    final SettingsService settingsService = Get.find<SettingsService>();
    Settings settings = settingsService.settings.value;

    return SizedBox(
      height: 200,
      width: 300,
      child: ListView.builder(
        itemCount: settings.obsConnectionsHistory.length,
        itemBuilder: (context, index) {
          String url = settings.obsConnectionsHistory[index]['url']!;
          String password = settings.obsConnectionsHistory[index]['password']!;

          return ListTile(
            title: Text(url),
            onTap: () {
              controller.obsWebsocketUrlFieldController.text = url;
              controller.obsWebsocketPasswordFieldController.text = password;
              settingsService.settings.value = settings.copyWith(
                  obsWebsocketUrl: url, obsWebsocketPassword: password);
              settingsService.saveSettings();
              Get.back();
            },
          );
        },
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
