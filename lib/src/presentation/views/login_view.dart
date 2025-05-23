import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/app_info_service.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/presentation/controllers/login_view_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends GetView<LoginViewController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          child: Obx(
            () => loginScreen(
              context,
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(context) {
    return Column(
      children: [
        SizedBox(
          width: 250,
          child: TextButton.icon(
            label: Text.rich(
              TextSpan(
                text: "Login with ",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: 'Twitch',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            icon: const Padding(
              padding: EdgeInsets.all(8),
              child: Image(
                height: 24,
                width: 24,
                image: AssetImage(
                  'lib/assets/twitch/twitch_logo.png',
                ),
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              controller.login();
            },
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: 250,
          child: TextButton.icon(
            label: const Text.rich(
              TextSpan(
                text: "Login with ",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: 'Kick',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            icon: const Padding(
              padding: EdgeInsets.all(8),
              child: Image(
                height: 24,
                width: 24,
                image: AssetImage(
                  'lib/assets/kick/kickLogo.png',
                ),
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              controller.loginKick();
            },
          ),
        ),
        Divider(
          height: 30,
          indent: 60,
          endIndent: 60,
          color: Colors.grey[900],
        ),
        SizedBox(
          width: 250,
          child: TextButton(
            key: const Key("maybe_later_key"),
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              controller.homeWitoutLogin();
            },
            child: Text(
              "maybe_later".tr,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loadingCircle(context) {
    return Obx(
      () => Column(
        spacing: 20,
        children: [
          Visibility(
            visible: controller.twitchCredentials.value == null,
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          Row(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (controller.twitchCredentials.value != null)
                CachedNetworkImage(
                  imageUrl: controller
                      .twitchCredentials.value!.twitchUser.profileImageUrl,
                  placeholder: (BuildContext context, String url) =>
                      CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  errorWidget: (BuildContext context, String url, error) =>
                      const Icon(Icons.error),
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 36,
                    backgroundImage: imageProvider,
                  ),
                )
              else
                const SizedBox(),
              if (controller.kickCredentials.value != null)
                CachedNetworkImage(
                  imageUrl:
                      controller.kickCredentials.value!.kickUser.profilePicture,
                  placeholder: (BuildContext context, String url) =>
                      CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  errorWidget: (BuildContext context, String url, error) =>
                      const Icon(Icons.error),
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 36,
                    backgroundImage: imageProvider,
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
          Visibility(
            visible: controller.twitchCredentials.value != null,
            child: Text(
              'Hey ${controller.twitchCredentials.value?.twitchUser.displayName ?? ""}',
            ),
          ),
          Text(
            controller.loadingMessage.value,
          ),
        ],
      ),
    );
  }

  Widget loginScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Image(
              image: AssetImage("lib/assets/irl_link_dark_trans_logo.png"),
              width: 200,
            ),
            Visibility(
              visible: Get.find<StoreService>().isSubscribed(),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 4,
                  bottom: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: const Text('Premium'),
              ),
            ),
          ],
        ),
        if (controller.isLoading.value)
          _loadingCircle(context)
        else
          _loginButton(context),
        Column(
          children: [
            const Text("Open Source Project by @LezdCS"),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    launchUrl(
                      Uri(
                        scheme: "https",
                        host: "github.com",
                        path: "/LezdCS/irl-link",
                      ),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: SvgPicture.asset(
                    './lib/assets/icon-github.svg',
                    semanticsLabel: 'github icon',
                    width: 25,
                    height: 25,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    launchUrl(
                      Uri(
                        scheme: "https",
                        host: "twitter.com",
                        path: "/LezdCS",
                      ),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: SvgPicture.asset(
                    './lib/assets/icon-twitter.svg',
                    semanticsLabel: 'twitter icon',
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text("Version: ${Get.find<AppInfoService>().version}"),
          ],
        ),
      ],
    );
  }
}
