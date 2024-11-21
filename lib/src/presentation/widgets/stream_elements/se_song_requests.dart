import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_song.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';

class SeSongRequests extends GetView<StreamelementsViewController> {
  const SeSongRequests({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        String? jwt = Get.find<SettingsService>()
            .settings
            .value
            .streamElementsSettings
            .jwt;
        return Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              Visibility(
                visible: jwt != null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        // const Icon(Icons.skip_previous),
                        InkWell(
                          onTap: () {
                            controller.updatePlayerState(
                              controller.isPlaying.value ? 'pause' : 'play',
                              jwt!,
                            );
                          },
                          child: controller.isPlaying.value
                              ? const Icon(Icons.pause)
                              : const Icon(Icons.play_arrow_outlined),
                        ),
                        InkWell(
                          onTap: () {
                            controller.nextSong(jwt!);
                          },
                          child: const Icon(Icons.skip_next),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        controller.resetQueue(jwt!);
                      },
                      child: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              const Text(
                'Now Playing',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (controller.currentSong.value != null) _songRow(context, controller.currentSong.value!, false, jwt) else const Text("No song playing."),
              const Padding(
                padding: EdgeInsets.only(bottom: 15),
              ),
              Text.rich(
                overflow: TextOverflow.ellipsis,
                TextSpan(children: [
                  TextSpan(
                    text: "queue".tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: " (${controller.songRequestQueue.length} videos)",
                  ),
                ],),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: controller.songRequestScrollController,
                  itemCount: controller.songRequestQueue.length,
                  itemBuilder: (BuildContext context, int index) {
                    SeSong song = controller.songRequestQueue[index];
                    return _songRow(context, song, true, jwt);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _songRow(
    BuildContext context,
    SeSong song,
    bool removable,
    String? jwt,
  ) {
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
                Text.rich(
                  overflow: TextOverflow.ellipsis,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: song.channel,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: " - ",
                      ),
                      TextSpan(
                        text: song.title,
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  overflow: TextOverflow.ellipsis,
                  TextSpan(children: [
                    const TextSpan(
                      text: "Duration: ",
                    ),
                    TextSpan(
                      text: song.duration.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: "s",
                    ),
                  ],),
                ),
              ],
            ),
          ),
          Visibility(
            visible: jwt != null && removable,
            child: InkWell(
              onTap: () {
                controller.removeSong(song, jwt!);
              },
              child: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
