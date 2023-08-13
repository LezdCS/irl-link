import 'package:flutter/material.dart';

import '../../../controllers/settings_view_controller.dart';

Widget inAppPurchaseDialog(
  BuildContext context,
  SettingsViewController controller,
) {
  String price = controller.homeViewController.products
      .firstWhere(
        (element) => element.id == "irl_premium_subscription",
      )
      .price;

  return Column(
    children: [
      const Text('IRL Link Premium'),
      Text(price),
      const Column(
        children: [
          Row(
            children: [
              Icon(Icons.check_circle_outline_rounded),
              Text('StreamElements events view')
              // todo: preview button show feature screen
            ],
          ),
        ],
      ),
      TextButton(
        onPressed: () {
          controller.purchase();
        },
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 12),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        child: Text(
          "Purchase for $price",
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
              fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
