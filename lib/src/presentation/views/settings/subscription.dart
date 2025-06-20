import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:irllink/src/presentation/widgets/in_app_purchase_dialog.dart';

class Subscription extends GetView<SettingsViewController> {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    final storeService = Get.find<StoreService>();
    String price = storeService.getSubscriptionPrice();
    RxBool storeFound = storeService.storeFound;

    return Obx(
      () {
        if (!storeFound.value || price == "") {
          return const Text('Error loading the subscription module.');
        }

        bool isSubscribed = storeService.isSubscribed();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "subscription".tr,
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 20,
              ),
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
                          isSubscribed ? "subscribed".tr : "not_subscribed".tr,
                          style: TextStyle(
                            color: isSubscribed
                                ? Colors.green[400]
                                : Colors.red[400],
                            fontSize: 16,
                          ),
                        ),
                        if (isSubscribed)
                          Text("subscribed_def".tr)
                        else
                          Text(
                            "not_subscribed_def".tr,
                            style: TextStyle(
                              color: Colors.grey[200],
                              fontSize: 16,
                            ),
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
                          price,
                          style: const TextStyle(fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
