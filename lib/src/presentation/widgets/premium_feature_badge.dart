import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget premiumFeatureBadge(
  BuildContext context,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    margin: const EdgeInsets.only(left: 4),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.tertiary,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          "premium_feature".tr,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        const Icon(
          Icons.star,
          size: 12,
          color: Colors.yellow,
        ),
      ],
    ),
  );
}
