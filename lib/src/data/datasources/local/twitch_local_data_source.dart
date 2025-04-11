import 'dart:convert';

import 'package:get_storage/get_storage.dart';
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
  final GetStorage _storage;

  TwitchLocalDataSourceImpl({
    required this.talker,
    GetStorage? storage,
  }) : _storage = storage ?? GetStorage();

  @override
  Future<void> storeCredentials(TwitchCredentialsDTO credentials) async {
    String jsonData = jsonEncode(credentials);
    await _storage.write('twitchData', jsonData);
    talker.logCustom(
      TwitchLog('Twitch credentials saved in local.'),
    );
  }

  @override
  Future<TwitchCredentialsDTO?> getCredentials() async {
    talker.logCustom(
      TwitchLog(
        'Getting Twitch credentials from local storage.',
      ),
    );
    var twitchDataString = _storage.read('twitchData');

    if (twitchDataString != null) {
      Map<String, dynamic> twitchDataJson = jsonDecode(twitchDataString);
      return TwitchCredentialsDTO.fromJson(twitchDataJson);
    }
    return null;
  }

  @override
  Future<void> removeCredentials() async {
    await _storage.remove('twitchData');
    talker.logCustom(
      TwitchLog('Twitch credentials removed from local.'),
    );
  }
}
