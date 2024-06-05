import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/login_view_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;

class LoginView extends GetView<LoginViewController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<LoginViewController>();
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          child: Obx(
            () => loginScreen(
              context,
              controller.isLoading.value
                  ? _loadingCircle(context)
                  : _loginButton(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: InkWell(
            onTap: () {
              controller.login();
            },
            child: const Image(
              image: AssetImage("lib/assets/login.png"),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            controller.homeWitoutLogin();
          },
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            child: const Text(
              "Maybe later",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loadingCircle(context) {
    return Column(
      children: [
        const CircularProgressIndicator(),
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: Obx(
            () => Text(
              controller.loadingMessage.value,
            ),
          ),
        ),
      ],
    );
  }

  Widget loginScreen(BuildContext context, Widget content) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          "IRL LINK",
          style: TextStyle(
            fontSize: 34,
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold,
          ),
        ),
        content,
        Container(),
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
            Text("Version: ${globals.version}")
          ],
        ),
      ],
    );
  }
}
