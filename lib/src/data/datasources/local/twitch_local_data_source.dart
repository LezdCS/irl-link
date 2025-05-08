import 'dart:convert';

import 'package:irllink/data/database/database_helper.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/twitch/twitch_credentials_dto.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class TwitchLocalDataSource {
  Future<void> storeCredentials(TwitchCredentialsDTO credentials);
  Future<TwitchCredentialsDTO?> getCredentials();
  Future<void> removeCredentials();
}

class TwitchLocalDataSourceImpl implements TwitchLocalDataSource {
  final Talker talker;
  final DatabaseHelper _databaseHelper;

  TwitchLocalDataSourceImpl({
    required this.talker,
    DatabaseHelper? databaseHelper,
  }) : _databaseHelper = databaseHelper ?? DatabaseHelper.instance;

  @override
  Future<void> storeCredentials(TwitchCredentialsDTO credentials) async {
    final db = await _databaseHelper.database;

    // First remove any existing credentials
    await removeCredentials();

    await db.insert(
      'twitch_credentials',
      {
        'access_token': credentials.accessToken,
        'id_token': credentials.idToken,
        'refresh_token': credentials.refreshToken,
        'expires_in': credentials.expiresIn,
        'decoded_id_token': jsonEncode(credentials.decodedIdToken),
        'twitch_user': jsonEncode(credentials.twitchUser),
        'scopes': credentials.scopes,
      },
    );

    talker.logCustom(
      TwitchLog('Twitch credentials saved in database.'),
    );
  }

  @override
  Future<TwitchCredentialsDTO?> getCredentials() async {
    talker.logCustom(
      TwitchLog('Getting Twitch credentials from database.'),
    );

    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('twitch_credentials');

    if (maps.isEmpty) {
      return null;
    }

    final credentials = maps.first;
    final twitchDataJson = {
      'accessToken': credentials['access_token'],
      'idToken': credentials['id_token'],
      'refreshToken': credentials['refresh_token'],
      'expiresIn': credentials['expires_in'],
      'decodedIdToken': jsonDecode(credentials['decoded_id_token']),
      'twitchUser': jsonDecode(credentials['twitch_user']),
      'scopes': credentials['scopes'],
    };

    return TwitchCredentialsDTO.fromJson(twitchDataJson);
  }

  @override
  Future<void> removeCredentials() async {
    final db = await _databaseHelper.database;
    await db.delete('twitch_credentials');
    talker.logCustom(
      TwitchLog('Twitch credentials removed from database.'),
    );
  }
}
