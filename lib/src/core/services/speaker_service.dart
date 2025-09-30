import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/usecases/settings/get_general_settings.dart';

class SpeakerService extends GetxService {
  Timer? _keepAliveTimer;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isInitialized = false;

  SpeakerService({
    required this.getGeneralSettingsUseCase,
  });

  final GetGeneralSettingsUseCase getGeneralSettingsUseCase;

  Future<SpeakerService> init() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.stop);
    _isInitialized = true;
    return this;
  }

  Future<void> updateSettings() async {
    if (!_isInitialized) {
      return;
    }
    final generalSettingsResult = await getGeneralSettingsUseCase();
    generalSettingsResult.fold(
      (l) {},
      (r) {
        if (r.keepSpeakerOn) {
          _startKeepAlive();
        } else {
          _stopKeepAlive();
        }
      },
    );
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
      // Catch error but don't throw - we don't want to crash the app if this fails
    }
  }

  @override
  void onClose() {
    _stopKeepAlive();
    _audioPlayer.dispose();
    super.onClose();
  }
}
