import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';

abstract class StreamelementsRepository {
  Future<DataState<void>> login(StreamelementsAuthParams params);

  Future<DataState<void>> disconnect();

  Future<void> replayActivity(String token, SeActivity activity);

  Future<DataState<List<SeActivity>>> getLastActivities(
      String token, String channel);

  Future<DataState<List<SeOverlay>>> getOverlays(String token, String channel);

  Future<DataState<SeMe>> getMe(String token);

}
