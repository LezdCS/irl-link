import 'dart:convert';

import 'package:irllink/data/database/database_helper.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/kick/kick_credentials_dto.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class KickLocalDataSource {
  Future<void> storeCredentials(KickCredentialsDTO credentials);
  Future<KickCredentialsDTO?> getCredentials();
  Future<void> removeCredentials();
}

class KickLocalDataSourceImpl implements KickLocalDataSource {
  final Talker talker;
  final DatabaseHelper _databaseHelper;

  KickLocalDataSourceImpl({
    required this.talker,
    DatabaseHelper? databaseHelper,
  }) : _databaseHelper = databaseHelper ?? DatabaseHelper.instance;

  @override
  Future<void> storeCredentials(KickCredentialsDTO credentials) async {
    final db = await _databaseHelper.database;

    // First remove any existing credentials
    await removeCredentials();

    await db.insert(
      'kick_credentials',
      {
        'access_token': credentials.accessToken,
        'refresh_token': credentials.refreshToken,
        'expires_in': credentials.expiresIn,
        'kick_user': jsonEncode(credentials.kickUser),
        'scopes': credentials.scopes,
      },
    );

    talker.logCustom(
      KickLog('Kick credentials saved in database.'),
    );
  }

  @override
  Future<KickCredentialsDTO?> getCredentials() async {
    talker.logCustom(
      KickLog('Getting Kick credentials from database.'),
    );

    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('kick_credentials');

    if (maps.isEmpty) {
      return null;
    }

    return KickCredentialsDTO.fromJson(maps.first);
  }

  @override
  Future<void> removeCredentials() async {
    final db = await _databaseHelper.database;
    await db.delete('kick_credentials');
  }
}
