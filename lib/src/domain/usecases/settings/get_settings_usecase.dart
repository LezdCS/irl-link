import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class GetSettingsUseCase implements UseCase<Either<Failure, Settings>, void> {
  final SettingsRepository settingsRepository;

  GetSettingsUseCase(this.settingsRepository);

  @override
  Future<Either<Failure, Settings>> call({void params}) {
    return settingsRepository.getSettings();
  }
}
