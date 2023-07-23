import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamelementsUseCase {
  final StreamelementsRepository streamelementsRepository;
  StreamelementsUseCase({required this.streamelementsRepository});

  Future<DataState<void>> login({required StreamelementsAuthParams params}) {
    return streamelementsRepository.login(params);
  }

  Future<DataState<void>> disconnect() {
    return streamelementsRepository.disconnect();
  }

  Future<void> replayActivity(String token, SeActivity activity) {
    return streamelementsRepository.replayActivity(token, activity);
  }

  Future<DataState<List<SeOverlay>>> getOverlays(String token, String channel) {
    return streamelementsRepository.getOverlays(token, channel);
  }

  Future<DataState<SeMe>> getMe(String token) {
    return streamelementsRepository.getMe(token);
  }
}
