import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class ToggleObsUsecaseParams {
  final bool isConnected;

  ToggleObsUsecaseParams({required this.isConnected});
}

class ToggleObsUsecase
    extends UseCase<Either<Failure, void>, ToggleObsUsecaseParams> {
  final SettingsRepository settingsRepository;

  ToggleObsUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, void>> call({
    required ToggleObsUsecaseParams params,
  }) async {
    return settingsRepository.toggleObsConnection(params);
  }
}
