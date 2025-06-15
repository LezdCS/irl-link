import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';

class SpeakerService extends GetxService {
  final SettingsService settingsService;
  Timer? _keepAliveTimer;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isInitialized = false;

  SpeakerService({required this.settingsService});

  Future<SpeakerService> init() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.stop);
    _isInitialized = true;
    return this;
  }

  void updateSettings(Settings settings) {
    if (!_isInitialized) {
      return;
    }

    if (settings.generalSettings.keepSpeakerOn) {
      _startKeepAlive();
    } else {
      _stopKeepAlive();
    }
  }

  void _startKeepAlive() {
    _stopKeepAlive(); // Ensure we don't have multiple timers running

    _keepAliveTimer = Timer.periodic(
      const Duration(minutes: 5),
      (_) => _playKeepAliveSound(),
    );
  }

  void _stopKeepAlive() {
    _keepAliveTimer?.cancel();
    _keepAliveTimer = null;
    _audioPlayer.stop();
  }

  Future<void> _playKeepAliveSound() async {
    try {
      await _audioPlayer.play(AssetSource('../lib/assets/blank.mp3'));
    } catch (e) {
      // Log error but don't throw - we don't want to crash the app if this fails
      debugPrint('Failed to play keep-alive sound: $e');
    }
  }

  @override
  void onClose() {
    _stopKeepAlive();
    _audioPlayer.dispose();
    super.onClose();
  }
}
