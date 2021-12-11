import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/login_view_controller.dart';

class LoginView extends GetView<LoginViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (state) => loginScreen(),
        onLoading: loadingScreen(),
        onEmpty: Text('No data found'),
        onError: (error) => Text("error"),
      ),
    );
  }

  Widget loginScreen() {
    return Container(
      width: double.infinity,
      color: Color(0XFF282828),
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
    );
  }

  Widget loadingScreen() {
    return Container(
      width: double.infinity,
      color: Color(0XFF282828),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: 160,
              child: Image(
                image: AssetImage("lib/assets/logo.png"),
              ),
            ),
            Spacer(),
            Container(
              child: Center(
                child: Column(children: [
                  CircularProgressIndicator(),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Loading...",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ]),
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
    );
  }
}
