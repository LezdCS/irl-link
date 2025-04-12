import 'package:irllink/data/database/database_helper.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/stream_elements/se_credentials_dto.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class StreamelementsLocalDataSource {
  Future<void> storeCredentials(SeCredentialsDTO credentials);
  Future<SeCredentialsDTO?> getCredentials();
  Future<void> removeCredentials();
}

class StreamelementsLocalDataSourceImpl
    implements StreamelementsLocalDataSource {
  final Talker talker;
  final DatabaseHelper _databaseHelper;

  StreamelementsLocalDataSourceImpl({
    required this.talker,
    DatabaseHelper? databaseHelper,
  }) : _databaseHelper = databaseHelper ?? DatabaseHelper.instance;

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
    final seCredentialsJson = {
      'accessToken': credentials['access_token'],
      'refreshToken': credentials['refresh_token'],
      'expiresIn': credentials['expires_in'],
      'scopes': credentials['scopes'],
    };

    return SeCredentialsDTO.fromJson(seCredentialsJson);
  }

  @override
  Future<void> removeCredentials() async {
    final db = await _databaseHelper.database;
    await db.delete('streamelements_credentials');
    talker.logCustom(
      StreamElementsLog('StreamElements credentials removed from database.'),
    );
  }
}
