import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:talker_flutter/talker_flutter.dart';

class RemoteConfigService extends GetxService {
  RemoteConfigService({
    required this.talker,
  });

  final Talker talker;
  late FirebaseRemoteConfig _remoteConfig;

  Future<RemoteConfigService> init() async {
    _remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 30),
          minimumFetchInterval:
              kDebugMode ? Duration.zero : const Duration(hours: 1),
        ),
      );

      await _remoteConfig.setDefaults(const {
        'minimum_version_android': '2.11.3',
        'minimum_version_ios': '2.11.3',
        'kick_chat_push_key': '32cbd69e4b950bf97679',
        'irllink_auth_url': 'https://irllink.com/api/twitch-auth',
        'irllink_auth_url_dev': 'https://dev.irllink.com/api/twitch-auth',
        'irllink_refresh_token_url':
            'https://dev.irllink.com/api/twitch-refresh-token',
        'irllink_refresh_token_url_dev':
            'https://irllink.com/api/twitch-refresh-token',
        'irllink_refresh_se_token_url':
            'https://dev.irllink.com/api/streamelements/refresh-token',
        'irllink_refresh_se_token_url_dev':
            'https://dev.irllink.com/api/streamelements/refresh-token',
        'irllink_kick_auth_url': 'https://www.irllink.com/api/kick/auth',
        'irllink_kick_auth_url_dev': 'https://dev.irllink.com/api/kick/auth',
        'irllink_kick_token_url': 'https://irllink.com/api/kick/token',
        'irllink_kick_token_url_dev': 'https://dev.irllink.com/api/kick/token',
        'irllink_kick_refresh_token_url':
            'https://irllink.com/api/kick/refresh-token',
        'irllink_kick_refresh_token_url_dev':
            'https://dev.irllink.com/api/kick/refresh-token',
        'verify_android_purchase':
            'https://www.irllink.com/api/verify-android-purchase',
        'verify_android_purchase_dev':
            'https://dev.irllink.com/api/verify-android-purchase',
        'verify_ios_purchase':
            'https://www.irllink.com/api/verify-ios-purchase',
        'verify_ios_purchase_dev':
            'https://dev.irllink.com/api/verify-ios-purchase',
        'youtube_websocket_url': 'wss://youtube.irllink.com/wss',
        'irltools_obs_remote_base_url': '',
      });

      final updated = await _remoteConfig.fetchAndActivate();
      talker.info(
        'RemoteConfig fetched: updated=$updated status=${_remoteConfig.lastFetchStatus} time=${_remoteConfig.lastFetchTime}',
      );
    } catch (e, stack) {
      talker.handle(e, stack);
    }

    return this;
  }

  String getString(String key) {
    try {
      return _remoteConfig.getString(key);
    } catch (e, stack) {
      talker.handle(e, stack);
      return '';
    }
  }

  Future<String> fetchAndGetString(String key) async {
    try {
      final updated = await _remoteConfig.fetchAndActivate();
      talker.info(
        'RemoteConfig on-demand fetch for key=$key updated=$updated status=${_remoteConfig.lastFetchStatus} time=${_remoteConfig.lastFetchTime}',
      );
    } catch (e, stack) {
      talker.handle(e, stack);
    }
    return getString(key);
  }
}
