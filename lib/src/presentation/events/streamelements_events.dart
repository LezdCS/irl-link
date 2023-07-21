import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
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

  Future<DataState<void>> login({required StreamelementsAuthParams params}) {
    return streamelementsUseCase.login(params: params);
  }

  Future<DataState<void>> disconnect() {
    return streamelementsUseCase.disconnect();
  }

  Future<void> replayActivity(String token, SeActivity activity) {
    return streamelementsUseCase.replayActivity(token, activity);
  }

  Future<DataState<List<SeOverlay>>> getOverlays(String token, String channel) {
    return streamelementsUseCase.getOverlays(token, channel);
  }

  Future<DataState<SeMe>> getMe(String token) {
    return streamelementsUseCase.getMe(token);
  }

  Future<DataState<Settings>> getSettings() {
    return settingsUseCase.getSettings();
  }
}
