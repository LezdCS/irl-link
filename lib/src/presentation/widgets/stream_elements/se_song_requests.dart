import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';

import '../../../domain/entities/se_song.dart';

class SeSongRequests extends GetView {
  final StreamelementsViewController controller;

  SeSongRequests({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  children: [
                    Icon(Icons.skip_previous),
                    Icon(Icons.pause), //Icon(Icons.play_arrow_outlined),
                    InkWell(
                      onTap: () {
                        controller.nextSong();
                      },
                      child: Icon(Icons.skip_next),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    controller.resetQueue();
                  },
                  child: Icon(Icons.delete),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Text(
              'Now Playing',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontWeight: FontWeight.bold,
              ),
            ),
            controller.songRequestQueue.length > 0
                ? _songRow(context, controller.songRequestQueue.first)
                : Text("No song request in queue."),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
            ),
            RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(children: [
                TextSpan(
                  text: "Queue ",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "(" +
                      controller.songRequestQueue.length.toString() +
                      " videos)",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
              ]),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                controller: controller.songRequestScrollController,
                itemCount: controller.songRequestQueue.length - 1,
                itemBuilder: (BuildContext context, int index) {
                  SeSong song = controller.songRequestQueue[index + 1];
                  return _songRow(context, song);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _songRow(BuildContext context, SeSong song) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      margin: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: song.channel,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                      TextSpan(
                        text: " - ",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                      TextSpan(
                        text: song.title,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      )
                    ],
                  ),
                ),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Duration: ",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                    TextSpan(
                      text: song.duration,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              controller.removeSong(song);
            },
            child: Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
