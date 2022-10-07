import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/login_view_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends GetView<LoginViewController> {
  @override
  Widget build(BuildContext context) {
    Get.find<LoginViewController>();
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
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
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        onTap: () {
          controller.login();
        },
        child: Image(
          image: AssetImage("lib/assets/login.png"),
        ),
      ),
    );
  }

  Widget _loadingCircle(context) {
    return Column(
      children: [
        CircularProgressIndicator(),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Obx(
            () => Text(
              controller.loadingMessage.value,
              style: Theme.of(context).textTheme.bodyText1,
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
        Image(
          image: AssetImage("lib/assets/logo.png"),
        ),
        content,
        Container(),
        Column(
          children: [
            Text("Open Source Project by @LezdCS"),
            SizedBox(
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
                        path: "/LezdCS/irllink",
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
                SizedBox(
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
            )
          ],
        ),
      ],
    );
  }
}
