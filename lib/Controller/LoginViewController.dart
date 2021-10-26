import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
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
    var redirectScheme = "dev.lezd.www.irllink";

    //todo : ajouter un state
    final url = Uri.https('id.twitch.tv', '/oauth2/authorize', {
      'response_type': 'token',
      'client_id': clientId,
      'redirect_uri': 'https://irllink.lezd.dev/twitchauth',
      'scope': 'channel_editor',
      'force_verify': 'true'
    });

    debugPrint(url.toString());

    final result = await FlutterWebAuth.authenticate(
      url: url.toString(),
      callbackUrlScheme: redirectScheme,
    );
    debugPrint(Uri.parse(result).queryParameters.toString());
    final token = Uri.parse(result).queryParameters['access_token'];
    debugPrint(token);
  }
}
