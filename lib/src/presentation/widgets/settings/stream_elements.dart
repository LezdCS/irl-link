import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../controllers/settings_view_controller.dart';

class StreamElements extends GetView {
  const StreamElements({
    super.key,
    required this.controller,
  });

  @override
  final SettingsViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'StreamElements',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              margin: const EdgeInsets.only(left: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Wrap(
                children: [
                  Text(
                    "Premium feature",
                    style: TextStyle(
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
          ],
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Obx(
            () => Column(
              children: [
                controller.homeViewController.seCredentials.value != null &&
                        controller.homeViewController.seMe.value != null
                    ? Column(
                        children: [
                          _profile(
                            controller.homeViewController.seMe.value!,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 7,
                                child: TextFormField(
                                  controller: controller.seJwtInputController,
                                  obscureText: !controller.seJwtShow.value,
                                  onChanged: (value) {
                                    controller
                                            .homeViewController.settings.value =
                                        controller
                                            .homeViewController.settings.value
                                            .copyWith(
                                      streamElementsSettings: controller
                                          .homeViewController
                                          .settings
                                          .value
                                          .streamElementsSettings!
                                          .copyWith(jwt: value),
                                    );
                                    controller.saveSettings();
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 7),
                                    enabledBorder: Theme.of(context)
                                        .inputDecorationTheme
                                        .border,
                                    hintText: 'JWT',
                                    labelText: 'JWT',
                                    labelStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
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
                                            !controller
                                                .obsWebsocketUrlShow.value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          _jwtExplanation(context),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 7,
                                child: TextFormField(
                                  controller:
                                      controller.seOverlayTokenInputController,
                                  obscureText:
                                      !controller.seOverlayTokenShow.value,
                                  onChanged: (value) {
                                    controller
                                            .homeViewController.settings.value =
                                        controller
                                            .homeViewController.settings.value
                                            .copyWith(
                                      streamElementsSettings: controller
                                          .homeViewController
                                          .settings
                                          .value
                                          .streamElementsSettings!
                                          .copyWith(overlayToken: value),
                                    );
                                    controller.saveSettings();
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 7),
                                    enabledBorder: Theme.of(context)
                                        .inputDecorationTheme
                                        .border,
                                    hintText: 'Token',
                                    labelText: 'Overlay Token',
                                    labelStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
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
                                            !controller
                                                .obsWebsocketUrlShow.value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Same as above for the overlay token',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                            ),
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: InkWell(
                              onTap: (() =>
                                  {controller.disconnectStreamElements()}),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "lib/assets/streamelements/seLogo.png",
                                    ),
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    'Logout',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : InkWell(
                        onTap: (() => {controller.loginStreamElements()}),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                  "lib/assets/streamelements/seLogo.png"),
                              width: 30,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Login with StreamElements',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _profile(SeMe me) {
    return Row(
      children: [
        CircleAvatar(
          foregroundImage: NetworkImage(me.avatar),
          radius: 20,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(me.displayName),
      ],
    );
  }

  Widget _jwtExplanation(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          const TextSpan(
            text: 'To get your Access Token ',
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
          const TextSpan(
            text: '. Then press "Show Secret" and copy your JWT Token!',
          ),
        ],
      ),
    );
  }
}
