import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_song.dart';

abstract class StreamelementsRepository {
  Future<DataState<void>> login(StreamelementsAuthParams params);

  Future<DataState<void>> disconnect();

  Future<void> replayActivity(String token, SeActivity activity);

  Future<DataState<List<SeActivity>>> getLastActivities(
      String token, String channel);

  Future<DataState<List<SeOverlay>>> getOverlays(String token, String channel);

  Future<DataState<SeMe>> getMe(String token);

  Future<DataState<List<SeSong>>> getSongQueue(String token, String userId);

  Future<DataState<SeSong>> getSongPlaying(String token, String userId);

  Future<void> updatePlayerState(String token, String userId, String state);

  Future<void> nextSong(String token, String userId);

  Future<void> removeSong(String token, String userId, String songId);

  Future<void> resetQueue(String token, String userId);
}
