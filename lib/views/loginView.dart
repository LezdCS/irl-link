import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //TODO: dropdown pour la langue
          Container(
            child: Text("IRL Link"),
          ),
          Container(
            child: InkWell(
              onTap: () {
                //TODO:  twitch login
                //   Get.to()
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
    );
  }
}
