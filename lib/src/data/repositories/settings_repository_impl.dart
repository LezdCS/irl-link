import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/utils/mapper.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/datasources/local/settings_local_data_source.dart';
import 'package:irllink/src/data/entities/settings_dto.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final Mappr _mappr;
  final Talker talker;
  final SettingsLocalDataSource _localDataSource;

  SettingsRepositoryImpl({
    required this.talker,
    required SettingsLocalDataSource localDataSource,
  })  : _mappr = Mappr(),
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, Settings>> getSettings() async {
    talker.logCustom(SettingsLog('Retrieving settings.'));
    final settingsDTO = await _localDataSource.getSettings();
    if (settingsDTO != null) {
      Settings settings = _mappr.convert<SettingsDTO, Settings>(settingsDTO);
      return Right(settings);
    }
    talker.info('No settings found, returning blank settings.');
    SettingsDTO blankSettingsDTO = SettingsDTO.blank();
    Settings settings = _mappr.convert<SettingsDTO, Settings>(blankSettingsDTO);
    return Right(settings);
  }

  @override
  Future<Either<Failure, void>> setSettings(Settings settings) async {
    SettingsDTO settingsDTO = _mappr.convert<Settings, SettingsDTO>(settings);
    await _localDataSource.setSettings(settingsDTO);
    return const Right(null);
  }
}
