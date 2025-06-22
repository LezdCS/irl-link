import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings/obs_settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class GetObsCredentialsUsecase
    extends UseCase<Either<Failure, ObsSettings>, void> {
  final SettingsRepository settingsRepository;

  GetObsCredentialsUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, ObsSettings>> call({required void params}) async {
    return settingsRepository.getObsCredentials();
  }
}
