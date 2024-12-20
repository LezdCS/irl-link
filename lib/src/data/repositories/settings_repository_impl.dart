import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/utils/mapper.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/settings_dto.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final Mappr _mappr;
  final Talker talker;
  SettingsRepositoryImpl({required this.talker}) : _mappr = Mappr();

  @override
  Future<Either<Failure, Settings>> getSettings() async {
    final box = GetStorage();
    talker.logCustom(SettingsLog('Retrieving settings.'));
    var settingsString = box.read('settings');
    if (settingsString != null) {
      talker.logCustom(SettingsLog('Settings found.'));
      Map<String, dynamic> settingsJson = jsonDecode(settingsString);
      SettingsDTO settingsDTO = SettingsDTO.fromJson(settingsJson);
      talker.logCustom(SettingsLog('Settings JSON: $settingsJson'));
      Settings settings = _mappr.convert<SettingsDTO, Settings>(settingsDTO);
      return Right(settings);
    }
    talker.info('No settings found.');
    SettingsDTO settingsDTO = SettingsDTO.blank();
    Settings settings = _mappr.convert<SettingsDTO, Settings>(settingsDTO);
    return Right(settings);
  }

  @override
  Future<Either<Failure, void>> setSettings(Settings settings) async {
    final box = GetStorage();
    SettingsDTO settingsDTO = _mappr.convert<Settings, SettingsDTO>(settings);
    String settingsJson = jsonEncode(settingsDTO.toJson());
    talker.logCustom(SettingsLog('Saving settings: $settingsJson'));
    box.write('settings', settingsJson);
    return const Right(null);
  }
}
