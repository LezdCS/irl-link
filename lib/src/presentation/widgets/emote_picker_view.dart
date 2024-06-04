import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:transparent_image/transparent_image.dart';

class EmotePickerView extends GetView {
  final HomeViewController homeViewController;

  const EmotePickerView({
    super.key,
    required this.homeViewController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF282828),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              textAlignVertical: TextAlignVertical.center,
              onChanged: (value) => homeViewController.searchEmote(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                ),
                border: InputBorder.none,
                hintText: 'Emote name',
                isDense: true,
                contentPadding: EdgeInsets.only(left: 5),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              color: const Color(0xFF121212),
              child: Obx(
                () => GridView.builder(
                  padding: const EdgeInsets.only(top: 5),
                  itemCount: homeViewController.twitchEmotes.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        String text =
                            homeViewController.chatInputController.text;
                        bool isLastCharSpace = text.isNotEmpty
                            ? text[text.length - 1] == " "
                            : false;
                        homeViewController.chatInputController.text =
                            "$text${isLastCharSpace ? "" : " "}${homeViewController.twitchEmotes[i].name} ";
                      },
                      child: FadeInImage.memoryNetwork(
                        image: homeViewController.twitchEmotes[i].url1x,
                        placeholder: kTransparentImage,
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
