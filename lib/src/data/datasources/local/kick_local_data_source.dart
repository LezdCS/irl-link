import 'package:irllink/data/database/database_helper.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/kick/kick_credentials_dto.dart';
import 'package:irllink/src/data/entities/kick/kick_user_dto.dart';
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

    // Insert user data
    await db.insert(
      'kick_users',
      {
        'user_id': credentials.kickUser.userId,
        'name': credentials.kickUser.name,
        'email': credentials.kickUser.email,
        'profile_picture': credentials.kickUser.profilePicture,
      },
    );

    // Insert credentials
    await db.insert(
      'kick_credentials',
      {
        'access_token': credentials.accessToken,
        'refresh_token': credentials.refreshToken,
        'expires_in': credentials.expiresIn,
        'user_id': credentials.kickUser.userId,
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

    // Get credentials
    final List<Map<String, dynamic>> credentialsMaps =
        await db.query('kick_credentials');
    if (credentialsMaps.isEmpty) {
      return null;
    }

    final credentials = credentialsMaps.first;

    // Get user data
    final List<Map<String, dynamic>> userMaps = await db.query(
      'kick_users',
      where: 'user_id = ?',
      whereArgs: [credentials['user_id']],
    );

    if (userMaps.isEmpty) {
      return null;
    }

    final user = userMaps.first;

    credentials['kickUser'] = KickUserDTO.fromJson(user);

    KickCredentialsDTO.fromJson(credentials);
    return KickCredentialsDTO.fromJson(credentials);
    // return KickCredentialsDTO(
    //   accessToken: credentials['access_token'],
    //   refreshToken: credentials['refresh_token'],
    //   expiresIn: credentials['expires_in'],
    //   kickUser: KickUserDTO(
    //     userId: user['user_id'],
    //     name: user['name'],
    //     email: user['email'],
    //     profilePicture: user['profile_picture'],
    //   ),
    //   scopes: credentials['scopes'],
    // );
  }

  @override
  Future<void> removeCredentials() async {
    final db = await _databaseHelper.database;

    // Get user_id from credentials before deleting
    final List<Map<String, dynamic>> credentials =
        await db.query('kick_credentials');
    if (credentials.isNotEmpty) {
      final userId = credentials.first['user_id'];

      // Delete credentials
      await db.delete('kick_credentials');

      // Delete user
      await db.delete(
        'kick_users',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
    }
  }
}
