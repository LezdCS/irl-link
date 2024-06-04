import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/store_controller.dart';

import '../../../controllers/settings_view_controller.dart';

Widget inAppPurchaseDialog(
  BuildContext context,
  SettingsViewController controller,
) {
  String price = Get.find<StoreController>().getSubscriptionPrice();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'StreamElements',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle_outline_rounded,
                          size: 18,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Events list view',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 13),
                        )
                      ],
                    ),
                    const Wrap(
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
                        )
                      ],
                    ),
                    const Wrap(
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
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            'You will be billed $price every month. \n You can cancel your subscription anytime from your Google Play Store application.',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 12),
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () {
                  controller.storeController.purchase();
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 12),
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                child: Text(
                  "Subscribe for $price",
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
