import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/LoginViewController.dart';

class LoginView extends GetView<LoginViewController> {
  final LoginViewController controller = Get.put(LoginViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Color(0XFF480A52),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: 160,
                child: Image(
                  image: AssetImage("lib/assets/logo.png"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 40),
                width: 300,
                child: InkWell(
                  onTap: () {
                    controller.login();
                  },
                  child: Image(image: AssetImage("lib/assets/ButtonLogin.png")),
                ),
              ),
              Spacer(),
              Container(
                height: 200,
                width: 200,
                child: SvgPicture.asset(
                  './lib/assets/waves.svg',
                  semanticsLabel: 'Waves',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
