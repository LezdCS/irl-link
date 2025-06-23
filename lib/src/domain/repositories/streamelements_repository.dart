import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/domain/entities/settings/stream_elements_settings.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_credentials.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_song.dart';

abstract class StreamelementsRepository {
  Future<Either<Failure, SeCredentials>> login(StreamelementsAuthParams params);

  Future<Either<Failure, SeCredentials>> refreshAccessToken(
    SeCredentials seCredentials,
  );

  Future<Either<Failure, void>> disconnect(String accessToken);

  Future<Either<Failure, SeCredentials>> getSeCredentialsFromLocal();

  Future<Either<Failure, void>> replayActivity(
    String token,
    SeActivity activity,
  );

  Future<Either<Failure, List<SeActivity>>> getLastActivities(
    String token,
    String channel,
  );

  Future<Either<Failure, List<SeOverlay>>> getOverlays(
    String token,
    String channel,
  );

  Future<Either<Failure, SeMe>> getMe(String token);

  Future<Either<Failure, List<SeSong>>> getSongQueue(
    String token,
    String userId,
  );

  Future<Either<Failure, SeSong>> getSongPlaying(String token, String userId);

  Future<Either<Failure, void>> updatePlayerState(
    String token,
    String userId,
    String state,
  );

  Future<Either<Failure, void>> nextSong(String token, String userId);

  Future<Either<Failure, void>> removeSong(
    String token,
    String userId,
    String songId,
  );

  Future<Either<Failure, void>> resetQueue(String token, String userId);

  Future<Either<Failure, void>> updateStreamElementsSettings(
    StreamElementsSettings settings,
  );

  Future<Either<Failure, StreamElementsSettings>> getStreamElementsSettings();
}
