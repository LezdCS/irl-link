import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:transparent_image/transparent_image.dart';

class EmotePickerView extends GetView {
  final HomeViewController homeViewController;

  EmotePickerView({
    required this.homeViewController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              color: Color(0xFF121212),
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
                      child: FadeInImage.memoryNetwork(
                        image: homeViewController.twitchEmotes[i].url1x,
                        placeholder: kTransparentImage,
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
