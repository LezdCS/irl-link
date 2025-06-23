import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:irllink/data/database/database_helper.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/settings/stream_elements_settings_dto.dart';
import 'package:irllink/src/data/entities/stream_elements/se_credentials_dto.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class StreamelementsLocalDataSource {
  Future<void> storeCredentials(SeCredentialsDTO credentials);
  Future<SeCredentialsDTO?> getCredentials();
  Future<void> removeCredentials();
  Future<void> storeStreamElementsSettings(StreamElementsSettingsDTO settings);
  Future<StreamElementsSettingsDTO?> getStreamElementsSettings();
}

class StreamelementsLocalDataSourceImpl
    implements StreamelementsLocalDataSource {
  final Talker talker;
  final DatabaseHelper _databaseHelper;
  final GetStorage _storage;

  StreamelementsLocalDataSourceImpl({
    required this.talker,
    GetStorage? storage,
    DatabaseHelper? databaseHelper,
  })  : _storage = storage ?? GetStorage(),
        _databaseHelper = databaseHelper ?? DatabaseHelper.instance;

  @override
  Future<void> storeCredentials(SeCredentialsDTO credentials) async {
    final db = await _databaseHelper.database;

    // First remove any existing credentials
    await removeCredentials();

    await db.insert(
      'streamelements_credentials',
      {
        'access_token': credentials.accessToken,
        'refresh_token': credentials.refreshToken,
        'expires_in': credentials.expiresIn,
        'scopes': credentials.scopes,
      },
    );

    talker.logCustom(
      StreamElementsLog('StreamElements credentials saved in database.'),
    );
  }

  @override
  Future<SeCredentialsDTO?> getCredentials() async {
    talker.logCustom(
      StreamElementsLog('Getting StreamElements credentials from database.'),
    );

    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('streamelements_credentials');

    if (maps.isEmpty) {
      return null;
    }

    final credentials = maps.first;

    return SeCredentialsDTO.fromJson(credentials);
  }

  @override
  Future<void> removeCredentials() async {
    final db = await _databaseHelper.database;
    await db.delete('streamelements_credentials');
    talker.logCustom(
      StreamElementsLog('StreamElements credentials removed from database.'),
    );
  }

  @override
  Future<void> storeStreamElementsSettings(
    StreamElementsSettingsDTO settings,
  ) async {
    await _storage.write(
      'streamelements_settings',
      jsonEncode(settings.toJson()),
    );
  }

  @override
  Future<StreamElementsSettingsDTO?> getStreamElementsSettings() async {
    final settingsString = _storage.read('streamelements_settings');
    if (settingsString != null) {
      Map<String, dynamic> settingsJson = jsonDecode(settingsString);
      return StreamElementsSettingsDTO.fromJson(settingsJson);
    }
    return StreamElementsSettingsDTO.blank();
  }
}
