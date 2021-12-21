import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class AlertMessageView extends GetView {
  final Color color;
  final String message;
  final bool isProgress;

  AlertMessageView({
    required this.color,
    required this.message,
    required this.isProgress,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.only(bottom: 5, top: 5),
      color: color,
      duration: Duration(milliseconds: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Visibility(
            visible: isProgress,
            child: Container(
              margin: EdgeInsets.only(left: 8),
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
