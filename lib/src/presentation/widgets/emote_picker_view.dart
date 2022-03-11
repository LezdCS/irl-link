import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';

class EmotePickerView extends GetView {
  final HomeViewController homeViewController;

  EmotePickerView({
    required this.homeViewController,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.45,
      height: width * 0.50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: width * 0.1,
            decoration: BoxDecoration(
              color: Color(0xFF282828),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: TextField(
              style: TextStyle(color: Colors.white),
              textAlignVertical: TextAlignVertical.center,
              onChanged: (value) => homeViewController.searchEmote(value),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                ),
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                hintText: 'Emote name',
                isDense: true,
                contentPadding: EdgeInsets.only(left: 5),
              ),
            ),
          ),
          Container(
            height: width * 0.4,
            padding: EdgeInsets.only(left: 5, right: 5),
            color: Color(0xFF121212),
            child: Container(
              child: Obx(
                () => GridView.builder(
                  padding: EdgeInsets.only(top: 5),
                  itemCount: homeViewController.twitchEmotes.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () => homeViewController.chatInputController.text =
                          homeViewController.chatInputController.text +
                              " " +
                              homeViewController.twitchEmotes[i].name +
                              " ",
                      child: Image.network(
                        homeViewController.twitchEmotes[i].url1x,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Text(stackTrace!.toString());
                        },
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
