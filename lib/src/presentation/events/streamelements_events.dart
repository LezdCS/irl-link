import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_credentials.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_song.dart';
import 'package:irllink/src/domain/usecases/streamelements_usecase.dart';

import '../../domain/entities/settings.dart';
import '../../domain/usecases/settings_usecase.dart';

class StreamelementsEvents {
  final StreamelementsUseCase streamelementsUseCase;
  final SettingsUseCase settingsUseCase;

  StreamelementsEvents({
    required this.streamelementsUseCase,
    required this.settingsUseCase,
  });

  Future<DataState<SeCredentials>> login(
      {required StreamelementsAuthParams params}) {
    return streamelementsUseCase.login(params: params);
  }

  Future<DataState<void>> disconnect(String accessToken) {
    return streamelementsUseCase.disconnect(accessToken);
  }

  Future<void> replayActivity(String token, SeActivity activity) {
    return streamelementsUseCase.replayActivity(token, activity);
  }

  Future<DataState<List<SeOverlay>>> getOverlays(String token, String channel) {
    return streamelementsUseCase.getOverlays(token, channel);
  }

  Future<DataState<List<SeActivity>>> getLastActivities(
      String token, String channel) {
    return streamelementsUseCase.getLastActivities(token, channel);
  }

  Future<DataState<SeMe>> getMe(String token) {
    return streamelementsUseCase.getMe(token);
  }

  Future<DataState<Settings>> getSettings() {
    return settingsUseCase.getSettings();
  }

  Future<DataState<List<SeSong>>> getSongQueue(String token, String userId) {
    return streamelementsUseCase.getSongQueue(token, userId);
  }

  Future<DataState<SeSong>> getSongPlaying(String token, String userId) {
    return streamelementsUseCase.getSongPlaying(token, userId);
  }

  Future<void> updatePlayerState(String token, String userId, String state) {
    return streamelementsUseCase.updatePlayerState(token, userId, state);
  }

  Future<void> nextSong(String token, String userId) {
    return streamelementsUseCase.nextSong(token, userId);
  }

  Future<void> removeSong(String token, String userId, String songId) {
    return streamelementsUseCase.removeSong(token, userId, songId);
  }

  Future<void> resetQueue(String token, String userId) {
    return streamelementsUseCase.resetQueue(token, userId);
  }
}
