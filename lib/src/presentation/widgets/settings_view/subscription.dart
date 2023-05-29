import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';

class Subscription extends StatelessWidget {
  final SettingsViewController controller;

  const Subscription({required this.controller});

  @override
  Widget build(BuildContext context) {
    String? price = controller.homeViewController.products
            .firstWhereOrNull(
              (element) => element.id == "irl_premium_subscription",
            )
            ?.price ??
        "";
    bool isSubscribed =
        controller.homeViewController.purchases.firstWhereOrNull(
              (element) => element.productID == "irl_premium_subscription",
            ) !=
            null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Subscription",
          style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary, fontSize: 20),
        ),
        Padding(
          padding: EdgeInsets.only(left: 4, right: 4, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isSubscribed
                          ? Text(
                              "You are subscribed.",
                              style: TextStyle(
                                  color: Colors.green[400], fontSize: 16),
                            )
                          : Text(
                              "You are not subscribed.",
                              style: TextStyle(
                                  color: Colors.red[400], fontSize: 16),
                            ),
                      isSubscribed
                          ? Text("You can access every features of IRL Link!")
                          : Text(
                              "Subscribe to unlock every features!",
                              style: TextStyle(
                                  color: Colors.grey[200], fontSize: 16),
                            ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: !isSubscribed,
                child: Expanded(
                  flex: 3,
                  child: Container(
                    child: TextButton(
                      onPressed: () {
                        controller.purchase();
                      },
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(fontSize: 12),
                        backgroundColor: Colors.deepPurpleAccent,
                      ),
                      child: Text(
                        "Only $price",
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
