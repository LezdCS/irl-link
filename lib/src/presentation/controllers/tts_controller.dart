import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings.dart';

class TtsController extends GetxController {
  late FlutterTts flutterTts;
  RxList ttsLanguages = [].obs;
  RxList ttsVoices = [].obs;

  @override
  void onInit() {
    flutterTts = FlutterTts();
    if (Platform.isAndroid) {
      flutterTts.setEngine(flutterTts.getDefaultEngine.toString());
    }
    getTtsVoices();
    getTtsLanguages();
    super.onInit();
  }

  void initTts(Settings settings) async {
    //  The following setup allows background music and in-app audio session to continue simultaneously:
    await flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.ambient,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers
        ],
        IosTextToSpeechAudioMode.voicePrompt);

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
      //prevent the queue to continue if we come back from settings and turn off TTS
      flutterTts.stop();
    }
  }

  void getTtsVoices() {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.getVoices.then((value) => {
          ttsVoices.value = value,
          ttsVoices.sort((a, b) => a['name'].compareTo(b['name']))
        });
  }

  void getTtsLanguages() {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.getLanguages.then((value) => {
          ttsLanguages.value = value,
          ttsLanguages.sort((a, b) => a.compareTo(b))
        });
  }
}
