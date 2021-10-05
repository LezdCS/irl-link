import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irl_link/Controller/LoginViewController.dart';

class LoginView extends GetView<LoginViewController> {
  final LoginViewController controller = Get.put(LoginViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              //TODO: dropdown pour la langue
              Container(
                child: Text("IRL Link"),
              ),
              Container(
                child: InkWell(
                  onTap: () {
                    controller.login();
                  },
                  child: Text(
                    'Connect with Twitch',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(color: Color(0xFF6441A5)),
              ),
              Container(
                child: Row(
                  children: [Text("C.G.U"), Text("Contact")],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
