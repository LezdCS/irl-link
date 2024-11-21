import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart' show ChatMessage;
import 'package:irllink/src/domain/entities/settings.dart';

class TtsService extends GetxService {
  late FlutterTts flutterTts;
  RxList ttsLanguages = [].obs;
  RxList ttsVoices = [].obs;

  Future<TtsService> init() async {
    flutterTts = FlutterTts();
    if (Platform.isAndroid) {
      await flutterTts.setEngine(flutterTts.getDefaultEngine.toString());
    }
    await getTtsVoices();
    await getTtsLanguages();
    return this;
  }

  Future<void> initTts(Settings settings) async {
    //  The following setup allows background music and in-app audio session to continue simultaneously:
    await flutterTts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.ambient,
      [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers,
      ],
      IosTextToSpeechAudioMode.voicePrompt,
    );

    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setLanguage(settings.ttsSettings.language);
    await flutterTts.setSpeechRate(settings.ttsSettings.rate);
    await flutterTts.setVolume(settings.ttsSettings.volume);
    await flutterTts.setPitch(settings.ttsSettings.pitch);
    await flutterTts.setVoice(settings.ttsSettings.voice);

    if (Platform.isAndroid) {
      await flutterTts.setQueueMode(1);
    }

    if (!settings.ttsSettings.ttsEnabled) {
      // Prevent the queue to continue if we come back from settings and turn off TTS
      flutterTts.stop();
    }
  }

  Future<void> updateSettings(Settings settings) async {
    await flutterTts.setLanguage(settings.ttsSettings.language);
    await flutterTts.setSpeechRate(settings.ttsSettings.rate);
    await flutterTts.setVolume(settings.ttsSettings.volume);
    await flutterTts.setPitch(settings.ttsSettings.pitch);
    await flutterTts.setVoice(settings.ttsSettings.voice);
  }

  Future<void> getTtsVoices() async {
    await flutterTts.getVoices.then(
      (value) => {
        ttsVoices.value = value,
        ttsVoices.sort((a, b) => a['name'].compareTo(b['name'])),
      },
    );
  }

  Future<void> getTtsLanguages() async {
    await flutterTts.getLanguages.then(
      (value) => {
        ttsLanguages.value = value,
        ttsLanguages.sort((a, b) => a.compareTo(b)),
      },
    );
  }

  void readTts(ChatMessage message) {
    Settings settings = Get.find<SettingsService>().settings.value;

    // If the user is in the ignore list, we don't read the message
    if (settings.ttsSettings.ttsUsersToIgnore.contains(message.displayName)) {
      return;
    }

    // If we allow only vip to be read, we don't read the message if the user is not a vip
    if (settings.ttsSettings.ttsOnlyVip && !message.isVip) {
      return;
    }

    // If we allow only vip to be read, we don't read the message if the user is not a vip
    if (settings.ttsSettings.ttsOnlyMod && !message.isModerator) {
      return;
    }

    // If we allow only vip to be read, we don't read the message if the user is not a vip
    if (settings.ttsSettings.ttsOnlySubscriber && !message.isSubscriber) {
      return;
    }

    // If the prefix is in the ignore list, we don't read the message
    for (String prefix in settings.ttsSettings.prefixsToIgnore) {
      if (message.message.startsWith(prefix)) {
        return;
      }
    }
    // If the list of prefixs to use TTS only is not empty, we only read the message if it starts with one of the prefixs
    if (settings.ttsSettings.prefixsToUseTtsOnly.isNotEmpty) {
      for (String prefix in settings.ttsSettings.prefixsToUseTtsOnly) {
        if (!message.message.startsWith(prefix)) {
          return;
        }
      }
    }
    String text = "user_said_message".trParams(
      {'authorName': message.displayName, 'message': message.message},
    );
    if (settings.ttsSettings.ttsMuteViewerName) {
      text = message.message;
    }
    flutterTts.speak(text);
  }
}
