import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_song.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';


class SeSongRequests extends GetView {
  @override
  final StreamelementsViewController controller;

  const SeSongRequests({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  children: [
                    const Icon(Icons.skip_previous),
                    const Icon(Icons.pause), //Icon(Icons.play_arrow_outlined),
                    InkWell(
                      onTap: () {
                        controller.nextSong();
                      },
                      child: const Icon(Icons.skip_next),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    controller.resetQueue();
                  },
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Text(
              'Now Playing',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontWeight: FontWeight.bold,
              ),
            ),
            controller.songRequestQueue.isNotEmpty
                ? _songRow(context, controller.songRequestQueue.first)
                : const Text("No song request in queue."),
            const Padding(
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
                  text: "(${controller.songRequestQueue.length} videos)",
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
      padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      margin: const EdgeInsets.only(top: 8),
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
            child: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
