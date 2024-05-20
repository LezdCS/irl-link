import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_credentials.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_song.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamelementsUseCase {
  final StreamelementsRepository streamelementsRepository;
  StreamelementsUseCase({required this.streamelementsRepository});

  Future<DataState<SeCredentials>> login({required StreamelementsAuthParams params}) {
    return streamelementsRepository.login(params);
  }

  Future<DataState<SeCredentials>> refreshAccessToken({required SeCredentials seCredentials}) {
    return streamelementsRepository.refreshAccessToken(seCredentials);
  }

  Future<DataState<SeCredentials>> getSeCredentialsFromLocal() {
    return streamelementsRepository.getSeCredentialsFromLocal();
  }
  

  Future<DataState<void>> disconnect(String accessToken) {
    return streamelementsRepository.disconnect(accessToken);
  }

  Future<void> replayActivity(String token, SeActivity activity) {
    return streamelementsRepository.replayActivity(token, activity);
  }

  Future<DataState<List<SeOverlay>>> getOverlays(String token, String channel) {
    return streamelementsRepository.getOverlays(token, channel);
  }

  Future<DataState<List<SeActivity>>> getLastActivities(
      String token, String channel) {
    return streamelementsRepository.getLastActivities(token, channel);
  }

  Future<DataState<SeMe>> getMe(String token) {
    return streamelementsRepository.getMe(token);
  }

  Future<DataState<List<SeSong>>> getSongQueue(String token, String userId) {
    return streamelementsRepository.getSongQueue(token, userId);
  }

  Future<DataState<SeSong>> getSongPlaying(String token, String userId) {
    return streamelementsRepository.getSongPlaying(token, userId);
  }

  Future<void> updatePlayerState(String token, String userId, String state) {
    return streamelementsRepository.updatePlayerState(token, userId, state);
  }

  Future<void> nextSong(String token, String userId) {
    return streamelementsRepository.nextSong(token, userId);
  }

  Future<void> removeSong(String token, String userId, String songId) {
    return streamelementsRepository.removeSong(token, userId, songId);
  }

  Future<void> resetQueue(String token, String userId) {
    return streamelementsRepository.resetQueue(token, userId);
  }
}
