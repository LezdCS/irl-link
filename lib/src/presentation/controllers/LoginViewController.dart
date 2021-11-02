import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/presentation/views/homeView.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginViewController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    // Here you can fetch you datas from server
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
    var token = await loginTwitch();

    if (token != '') {
      Get.offAll(() => HomeView());
    }
  }

  loginTwitch() async {
    var clientId = "shuf0nmdw2ao8o3rw1xe4raodb9ug3";
    var redirectScheme = "dev.lezd.www.irllink";

    //todo : ajouter un nonce et un state
    final url = Uri.https('id.twitch.tv', '/oauth2/authorize', {
      'client_id': clientId,
      'redirect_uri': 'https://irllink.com/twitch/app/auth',
      'response_type': 'code',
      'scope': 'openid channel_editor chat:read chat:edit',
      'force_verify': 'true',
      'claims': '{"userinfo":{"picture":null, "preferred_username":null}}'
    });

    final result = await FlutterWebAuth.authenticate(
      url: url.toString(),
      callbackUrlScheme: redirectScheme,
      preferEphemeral: true,
    );

    final access_token = Uri.parse(result).queryParameters['access_token'];
    final id_token = Uri.parse(result).queryParameters['id_token'];
    final refresh_token = Uri.parse(result).queryParameters['refresh_token'];
    box.write('TwitchAccessToken', access_token);
    box.write('TwitchIdToken', id_token);
    box.write('TwitchRefreshToken', refresh_token);

    //todo : faire une vérif de l'id token
    Map<String, dynamic> decodedToken = JwtDecoder.decode(id_token!);
    box.write('username', decodedToken['preferred_username']);

    return access_token;
  }
}
