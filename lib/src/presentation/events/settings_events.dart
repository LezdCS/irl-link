import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_user.dart';
import 'package:irllink/src/domain/usecases/settings_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch_usecase.dart';
import 'package:sqflite/sqflite.dart';

class SettingsEvents {
  final SettingsUseCase settingsUseCase;
  final TwitchUseCase twitchUseCase;
  SettingsEvents({required this.twitchUseCase, required this.settingsUseCase});

  Future<DataState<Settings>> getSettings({required Database database}) {
    return settingsUseCase.getSettings(database: database);
  }

  Future<void> setSettings({required Settings settings, required Database database}) {
    return settingsUseCase.setSettings(settings: settings, database: database);
  }

  Future<DataState<List<TwitchUser>>> getTwitchUsers(
      {required List ids, required String accessToken}) {
    return twitchUseCase.getTwitchUsers(ids: ids, accessToken: accessToken);
  }

  Future<DataState<String>> logout({required String accessToken}) {
    return twitchUseCase.logout(accessToken: accessToken);
  }
}
