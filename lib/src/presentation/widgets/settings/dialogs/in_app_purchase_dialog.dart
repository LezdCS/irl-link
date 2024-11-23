import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget inAppPurchaseDialog(
  BuildContext context,
  SettingsViewController controller,
) {
  String price = Get.find<StoreService>().getSubscriptionPrice();
  String storeText = Platform.isAndroid ? 'Google Play Store' : 'App Store';
  return AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: Container(
      height: 400,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'IRL Link Premium',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Please consider subscribing only as a support method as most features are still on development!',
                style: TextStyle(fontSize: 13, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                'Features',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'StreamElements',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          size: 18,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Events list view',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          size: 18,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Media request control (no audio)',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          size: 18,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Overlays (audio on Android only)',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            'You will be billed $price every month. \n You can cancel your subscription anytime from your $storeText application.',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          if (Platform.isIOS)
            Text.rich(
              style: const TextStyle(fontSize: 13, color: Colors.grey),
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'To learn more, visit our ',
                  ),
                  WidgetSpan(
                    child: InkWell(
                      onTap: () {
                        launchUrlString(
                          "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/",
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: Text(
                        "Terms",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ),
                  const TextSpan(
                    text: ' and ',
                  ),
                  WidgetSpan(
                    child: InkWell(
                      onTap: () {
                        launchUrlString(
                          "https://github.com/LezdCS/irl-link/blob/master/PRIVACY_POLICY.md",
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ),
                  const TextSpan(
                    text: '.',
                  ),
                ],
              ),
            )
          else
            Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                ),
                child: Text(
                  "cancel".tr,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () {
                  controller.storeService.purchase();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                child: Text(
                  "subscribe_for".trParams({'price': price}),
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
