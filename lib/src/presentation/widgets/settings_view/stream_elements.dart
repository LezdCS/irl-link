import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../controllers/settings_view_controller.dart';

class StreamElements extends GetView {
  StreamElements({
    required this.controller,
  });

  final SettingsViewController controller;

  @override
  Widget build(BuildContext context) {
    bool isSubscribed =
        controller.homeViewController.purchases.firstWhereOrNull(
              (element) => element.productID == "irl_premium_subscription",
            ) !=
            null;
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'StreamElements',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 18,
                  ),
                ),
                WidgetSpan(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    margin: EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Wrap(
                      children: [
                        Text(
                          "Premium feature",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 12,
                          ),
                        ),
                        Icon(
                          CupertinoIcons.sparkles,
                          size: 12,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: controller.streamElementsFieldController,
            onChanged: (value) {
              controller.homeViewController.settings.value = controller
                  .homeViewController.settings.value
                  .copyWith(streamElementsAccessToken: value);
              controller.saveSettings();
            },
            obscureText: !controller.seJwtShow.value,
            enabled: isSubscribed ? true : false,
            decoration: InputDecoration(
              isDense: true,
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[700]!,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
              hintText: 'StreamElements Access Token',
              labelText: isSubscribed
                  ? 'StreamElements Access Token'
                  : 'Subscribe to unlock this feature',
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
              ),
              suffixIcon: IconButton(
                icon: Icon(controller.seJwtShow.value
                    ? Icons.visibility
                    : Icons.visibility_off),
                color: Theme.of(context).primaryIconTheme.color,
                onPressed: () {
                  controller.seJwtShow.value = !controller.seJwtShow.value;
                },
              ),
            ),
          ),
          SizedBox(height: 6),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'To get your Access Token ',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
                WidgetSpan(
                  child: InkWell(
                    onTap: () {
                      launchUrlString(
                        "https://streamelements.com/dashboard/account/channels",
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Text(
                      "click here",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                ),
                TextSpan(
                  text: '. Then press "Show Secret" and copy your JWT Token!',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
