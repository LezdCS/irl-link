import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings/tts_settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class GetTtsSettingsUsecase
    extends UseCase<Either<Failure, TtsSettings>, void> {
  final SettingsRepository settingsRepository;

  GetTtsSettingsUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, TtsSettings>> call({required void params}) async {
    return settingsRepository.getTtsSettings();
  }
}
