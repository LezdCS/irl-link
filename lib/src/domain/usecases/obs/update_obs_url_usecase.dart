import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings/obs_settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class UpdateObsSettingsUsecase
    extends UseCase<Either<Failure, void>, ObsSettings> {
  final SettingsRepository settingsRepository;

  UpdateObsSettingsUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, void>> call({required ObsSettings params}) async {
    return settingsRepository.updateObsSettings(params);
  }
}
