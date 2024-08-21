import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:twitch_chat/twitch_chat.dart';

class TtsService extends GetxService {
  late FlutterTts flutterTts;
  RxList ttsLanguages = [].obs;
  RxList ttsVoices = [].obs;

  late HomeViewController homeViewController;

  Future<TtsService> init() async {
    flutterTts = FlutterTts();
    if (Platform.isAndroid) {
      flutterTts.setEngine(flutterTts.getDefaultEngine.toString());
    }
    getTtsVoices();
    getTtsLanguages();
    return this;
  }

  void initTts(Settings settings) async {
    homeViewController = Get.find<HomeViewController>();

    //  The following setup allows background music and in-app audio session to continue simultaneously:
    await flutterTts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.ambient,
      [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers
      ],
      IosTextToSpeechAudioMode.voicePrompt,
    );

    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setLanguage(settings.ttsSettings!.language);
    await flutterTts.setSpeechRate(settings.ttsSettings!.rate);
    await flutterTts.setVolume(settings.ttsSettings!.volume);
    await flutterTts.setPitch(settings.ttsSettings!.pitch);
    await flutterTts.setVoice(settings.ttsSettings!.voice);

    if (Platform.isAndroid) {
      await flutterTts.setQueueMode(1);
    }

    if (!settings.ttsSettings!.ttsEnabled) {
      // Prevent the queue to continue if we come back from settings and turn off TTS
      flutterTts.stop();
    }
  }

  void getTtsVoices() {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.getVoices.then(
      (value) => {
        ttsVoices.value = value,
        ttsVoices.sort((a, b) => a['name'].compareTo(b['name']))
      },
    );
  }

  void getTtsLanguages() {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.getLanguages.then(
      (value) => {
        ttsLanguages.value = value,
        ttsLanguages.sort((a, b) => a.compareTo(b))
      },
    );
  }

  void readTts(ChatMessage message) {
    // If the user is in the ignore list, we don't read the message
    if (homeViewController.settings.value.ttsSettings!.ttsUsersToIgnore
        .contains(message.displayName)) {
      return;
    }

    // If we allow only vip to be read, we don't read the message if the user is not a vip
    if (homeViewController.settings.value.ttsSettings!.ttsOnlyVip &&
        !message.isVip) {
      return;
    }

    // If we allow only vip to be read, we don't read the message if the user is not a vip
    if (homeViewController.settings.value.ttsSettings!.ttsOnlyMod &&
        !message.isModerator) {
      return;
    }

    // If we allow only vip to be read, we don't read the message if the user is not a vip
    if (homeViewController.settings.value.ttsSettings!.ttsOnlySubscriber &&
        !message.isSubscriber) {
      return;
    }

    // If the prefix is in the ignore list, we don't read the message
    for (String prefix
        in homeViewController.settings.value.ttsSettings!.prefixsToIgnore) {
      if (message.message.startsWith(prefix)) {
        return;
      }
    }
    // If the list of prefixs to use TTS only is not empty, we only read the message if it starts with one of the prefixs
    if (homeViewController
        .settings.value.ttsSettings!.prefixsToUseTtsOnly.isNotEmpty) {
      for (String prefix in homeViewController
          .settings.value.ttsSettings!.prefixsToUseTtsOnly) {
        if (message.message.startsWith(prefix) == false) {
          return;
        }
      }
    }
    String text = "user_said_message".trParams(
      {'authorName': message.displayName, 'message': message.message},
    );
    if (homeViewController.settings.value.ttsSettings!.ttsMuteViewerName) {
      text = message.message;
    }
    Get.find<TtsService>().flutterTts.speak(text);
  }
}
