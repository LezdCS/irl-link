import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:irllink/src/presentation/widgets/premium_feature_badge.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StreamElements extends GetView<SettingsViewController> {
  const StreamElements({
    super.key,
  });

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
            premiumFeatureBadge(context),
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
                if (controller.homeViewController.streamelementsViewController
                        .value !=
                    null)
                  loggedIn(context)
                else
                  loginButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget loggedIn(BuildContext context) {
    Settings settings = Get.find<SettingsService>().settings.value;
    SeMe? seMe = controller.homeViewController.streamelementsViewController
        .value?.userSeProfile.value;

    final settingsService = Get.find<SettingsService>();

    return Column(
      children: [
        if (seMe != null)
          _profile(
            seMe,
          )
        else
          Container(),
        const SizedBox(
          height: 12,
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
                  settingsService.settings.value = settings.copyWith(
                    streamElementsSettings:
                        settings.streamElementsSettings.copyWith(jwt: value),
                  );
                  settingsService.saveSettings();
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                  hintText: 'JWT',
                  labelText: 'JWT',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.seJwtShow.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    color: Theme.of(context).primaryIconTheme.color,
                    onPressed: () {
                      controller.seJwtShow.value = !controller.seJwtShow.value;
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
                controller: controller.seOverlayTokenInputController,
                obscureText: !controller.seOverlayTokenShow.value,
                onChanged: (value) {
                  settingsService.settings.value = settings.copyWith(
                    streamElementsSettings: settings.streamElementsSettings
                        .copyWith(overlayToken: value),
                  );
                  settingsService.saveSettings();
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                  hintText: 'Token',
                  labelText: 'Overlay Token',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.seOverlayTokenShow.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    color: Theme.of(context).primaryIconTheme.color,
                    onPressed: () {
                      controller.seOverlayTokenShow.value =
                          !controller.seOverlayTokenShow.value;
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
        logoutButton(context),
      ],
    );
  }

  Widget logoutButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        color: Theme.of(context).colorScheme.tertiaryContainer,
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: InkWell(
        onTap: () => {controller.disconnectStreamElements()},
        child: const Row(
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
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return InkWell(
      onTap: () => {controller.loginStreamElements()},
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("lib/assets/streamelements/seLogo.png"),
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
    );
  }

  Widget _profile(SeMe me) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: me.avatar,
          placeholder: (BuildContext context, String url) =>
              const CircularProgressIndicator(),
          errorWidget: (BuildContext context, String url, error) =>
              const Icon(Icons.error),
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: 18,
            backgroundImage: imageProvider,
          ),
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
