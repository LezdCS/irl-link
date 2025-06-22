import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart'
    show ChatMessage;
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/tts_settings.dart';
import 'package:irllink/src/domain/usecases/tts/get_tts_settings_usecase.dart';

class TtsService extends GetxService {
  TtsService({required this.getTtsSettingsUsecase});

  late FlutterTts flutterTts;
  RxList ttsLanguages = [].obs;
  RxList ttsVoices = [].obs;

  late TtsSettings ttsSettings;

  final GetTtsSettingsUsecase getTtsSettingsUsecase;

  Future<TtsService> init() async {
    flutterTts = FlutterTts();
    if (Platform.isAndroid) {
      String engine = await flutterTts.getDefaultEngine;
      await flutterTts.setEngine(engine);
    }
    await getTtsVoices();
    await getTtsLanguages();
    await getTtsSettings();
    return this;
  }

  Future<void> getTtsSettings() async {
    final result = await getTtsSettingsUsecase(params: null);
    result.fold(
      (l) {},
      (r) {
        ttsSettings = r;
      },
    );
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
    await flutterTts.setLanguage(ttsSettings.language);
    await flutterTts.setSpeechRate(ttsSettings.rate);
    await flutterTts.setVolume(ttsSettings.volume);
    await flutterTts.setPitch(ttsSettings.pitch);
    await flutterTts.setVoice(ttsSettings.voice);

    if (Platform.isAndroid) {
      await flutterTts.setQueueMode(1);
    }

    if (!ttsSettings.ttsEnabled) {
      // Prevent the queue to continue if we come back from settings and turn off TTS
      flutterTts.stop();
    }
  }

  Future<void> updateSettings(Settings settings) async {
    await flutterTts.setLanguage(ttsSettings.language);
    await flutterTts.setSpeechRate(ttsSettings.rate);
    await flutterTts.setVolume(ttsSettings.volume);
    await flutterTts.setPitch(ttsSettings.pitch);
    await flutterTts.setVoice(ttsSettings.voice);
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
    // If the user is in the ignore list, we don't read the message
    if (ttsSettings.ttsUsersToIgnore.contains(message.displayName)) {
      return;
    }

    // If we allow only vip to be read, we don't read the message if the user is not a vip
    if (ttsSettings.ttsOnlyVip && !message.isVip) {
      return;
    }

    // If we allow only vip to be read, we don't read the message if the user is not a vip
    if (ttsSettings.ttsOnlyMod && !message.isModerator) {
      return;
    }

    // If we allow only vip to be read, we don't read the message if the user is not a vip
    if (ttsSettings.ttsOnlySubscriber && !message.isSubscriber) {
      return;
    }

    // If the prefix is in the ignore list, we don't read the message
    for (String prefix in ttsSettings.prefixsToIgnore) {
      if (message.message.startsWith(prefix)) {
        return;
      }
    }

    String finalMessage = message.message;

    // If the list of prefixs to use TTS only is not empty, we only read the message if it starts with one of the prefixs
    if (ttsSettings.prefixsToUseTtsOnly.isNotEmpty) {
      bool foundPrefix = false;

      for (String prefix in ttsSettings.prefixsToUseTtsOnly) {
        if (message.message.startsWith(prefix)) {
          finalMessage = message.message.substring(prefix.length).trim();
          foundPrefix = true;
          break;
        }
      }

      if (!foundPrefix) {
        return;
      }
    }
    String text = "user_said_message".trParams(
      {'authorName': message.displayName, 'message': finalMessage},
    );
    if (ttsSettings.ttsMuteViewerName) {
      text = finalMessage;
    }
    flutterTts.speak(text);
  }
}
