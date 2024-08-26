import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/presentation/widgets/settings/dialogs/in_app_purchase_dialog.dart';

class Subscription extends StatelessWidget {
  final SettingsViewController controller;

  const Subscription({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    String price = Get.find<StoreService>().getSubscriptionPrice();
    RxBool storeFound = Get.find<StoreService>().storeFound;

    if (storeFound.value == false || price == "") {
      return const Text('Error loading the subscription module.');
    }

    return Obx(
      () {
        bool isSubscribed = Get.find<StoreService>().isSubscribed();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Subscription",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isSubscribed
                              ? "You are subscribed."
                              : "You are not subscribed.",
                          style: TextStyle(
                            color: isSubscribed
                                ? Colors.green[400]
                                : Colors.red[400],
                            fontSize: 16,
                          ),
                        ),
                        isSubscribed
                            ? const Text(
                                "You can access every features of IRL Link!")
                            : Text(
                                "Subscribe to unlock every features!",
                                style: TextStyle(
                                    color: Colors.grey[200], fontSize: 16),
                              ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !isSubscribed,
                    child: Expanded(
                      flex: 3,
                      child: TextButton(
                        onPressed: () {
                          Get.dialog(inAppPurchaseDialog(context, controller));
                        },
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 12),
                          backgroundColor: Colors.deepPurpleAccent,
                        ),
                        child: Text(
                          "Only $price",
                          style: const TextStyle(fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
