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
    final db = await _databaseHelper.database;

    // Check if StreamElements settings already exist
    final existingSettings = await db.query('streamelements_settings');

    int seSettingsId;

    if (existingSettings.isNotEmpty) {
      // Update existing settings
      seSettingsId = existingSettings.first['id'] as int;

      await db.update(
        'streamelements_settings',
        {
          'show_follower_activity': settings.showFollowerActivity ? 1 : 0,
          'show_subscriber_activity': settings.showSubscriberActivity ? 1 : 0,
          'show_donation_activity': settings.showDonationActivity ? 1 : 0,
          'show_cheer_activity': settings.showCheerActivity ? 1 : 0,
          'show_raid_activity': settings.showRaidActivity ? 1 : 0,
          'show_host_activity': settings.showHostActivity ? 1 : 0,
          'show_merch_activity': settings.showMerchActivity ? 1 : 0,
          'jwt': settings.jwt,
          'overlay_token': settings.overlayToken,
        },
        where: 'id = ?',
        whereArgs: [seSettingsId],
      );

      // Delete existing muted overlays
      await db.delete(
        'streamelements_muted_overlays',
        where: 'streamelements_settings_id = ?',
        whereArgs: [seSettingsId],
      );
    } else {
      // Insert new settings
      seSettingsId = await db.insert('streamelements_settings', {
        'show_follower_activity': settings.showFollowerActivity ? 1 : 0,
        'show_subscriber_activity': settings.showSubscriberActivity ? 1 : 0,
        'show_donation_activity': settings.showDonationActivity ? 1 : 0,
        'show_cheer_activity': settings.showCheerActivity ? 1 : 0,
        'show_raid_activity': settings.showRaidActivity ? 1 : 0,
        'show_host_activity': settings.showHostActivity ? 1 : 0,
        'show_merch_activity': settings.showMerchActivity ? 1 : 0,
        'jwt': settings.jwt,
        'overlay_token': settings.overlayToken,
      });
    }

    // Insert muted overlays
    for (String overlayName in settings.mutedOverlays) {
      await db.insert('streamelements_muted_overlays', {
        'streamelements_settings_id': seSettingsId,
        'overlay_name': overlayName,
      });
    }
  }

  @override
  Future<StreamElementsSettingsDTO?> getStreamElementsSettings() async {
    final db = await _databaseHelper.database;

    // Get the main StreamElements settings
    final List<Map<String, dynamic>> seSettingsMaps =
        await db.query('streamelements_settings');

    if (seSettingsMaps.isEmpty) {
      return StreamElementsSettingsDTO.blank();
    }

    final seSettingsMap = seSettingsMaps.first;
    final seSettingsId = seSettingsMap['id'];

    // Get the muted overlays
    final mutedOverlaysMaps = await db.query(
      'streamelements_muted_overlays',
      where: 'streamelements_settings_id = ?',
      whereArgs: [seSettingsId],
    );

    // Build the StreamElementsSettingsDTO
    return StreamElementsSettingsDTO(
      showFollowerActivity: seSettingsMap['show_follower_activity'] == 1,
      showSubscriberActivity: seSettingsMap['show_subscriber_activity'] == 1,
      showDonationActivity: seSettingsMap['show_donation_activity'] == 1,
      showCheerActivity: seSettingsMap['show_cheer_activity'] == 1,
      showRaidActivity: seSettingsMap['show_raid_activity'] == 1,
      showHostActivity: seSettingsMap['show_host_activity'] == 1,
      showMerchActivity: seSettingsMap['show_merch_activity'] == 1,
      jwt: seSettingsMap['jwt'],
      overlayToken: seSettingsMap['overlay_token'],
      mutedOverlays:
          mutedOverlaysMaps.map((e) => e['overlay_name'] as String).toList(),
    );
  }
}
