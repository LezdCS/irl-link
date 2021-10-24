import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/views/homeView.dart';
import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher.dart';

class LoginViewController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    // Here you can fetch you product from server
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // Here, you can dispose your StreamControllers
    // you can cancel timers
    super.onClose();
  }

  Future<void> login() async {
    await loginTwitch();

    //box.write('twitchToken', token);
    //Get.offAll(HomeView());
  }

  loginTwitch() async {
    var clientId = "shuf0nmdw2ao8o3rw1xe4raodb9ug3";
    var redirectScheme = "dev.lezd.www.irllink://callback";
    var discoveryUrl =
        "https://id.twitch.tv/oauth2/.well-known/openid-configuration";

    FlutterAppAuth appAuth = FlutterAppAuth();

    final AuthorizationTokenResponse? result =
        await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        clientId,
        redirectScheme,
        discoveryUrl: discoveryUrl,
        scopes: ['openid'],
      ),
    );
  }
}
