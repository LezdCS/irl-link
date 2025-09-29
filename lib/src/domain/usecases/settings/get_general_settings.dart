import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings/general_settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class GetGeneralSettingsUseCase
    implements UseCase<Either<Failure, GeneralSettings>, void> {
  final SettingsRepository settingsRepository;

  GetGeneralSettingsUseCase(this.settingsRepository);

  @override
  Future<Either<Failure, GeneralSettings>> call({void params}) {
    return settingsRepository.getGeneralSettings();
  }
}
