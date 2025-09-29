import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings/general_settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class SetGeneralSettingsUseCase
    implements UseCase<Either<Failure, void>, GeneralSettings> {
  final SettingsRepository settingsRepository;

  SetGeneralSettingsUseCase(this.settingsRepository);

  @override
  Future<Either<Failure, void>> call({required GeneralSettings params}) {
    return settingsRepository.setGeneralSettings(params);
  }
}
