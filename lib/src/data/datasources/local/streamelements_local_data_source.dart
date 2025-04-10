import 'dart:convert';

import 'package:get_storage/get_storage.dart';
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
  final GetStorage _storage;

  StreamelementsLocalDataSourceImpl({
    required this.talker,
    GetStorage? storage,
  }) : _storage = storage ?? GetStorage();

  @override
  Future<void> storeCredentials(SeCredentialsDTO credentials) async {
    String jsonData = jsonEncode(credentials);
    await _storage.write('seCredentials', jsonData);
    talker.logCustom(
      StreamElementsLog('StreamElements credentials saved in local.'),
    );
  }

  @override
  Future<SeCredentialsDTO?> getCredentials() async {
    talker.logCustom(
      StreamElementsLog(
        'Getting StreamElements credentials from local storage.',
      ),
    );
    var seCredentialsString = _storage.read('seCredentials');

    if (seCredentialsString != null) {
      Map<String, dynamic> seCredentialsJson = jsonDecode(seCredentialsString);
      return SeCredentialsDTO.fromJson(seCredentialsJson);
    }
    return null;
  }

  @override
  Future<void> removeCredentials() async {
    await _storage.remove('seCredentials');
    talker.logCustom(
      StreamElementsLog('StreamElements credentials removed from local.'),
    );
  }
}
