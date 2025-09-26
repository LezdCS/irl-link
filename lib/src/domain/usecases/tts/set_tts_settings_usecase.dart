import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings/tts_settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class SetTtsSettingsUsecase
    extends UseCase<Either<Failure, void>, TtsSettings> {
  final SettingsRepository settingsRepository;

  SetTtsSettingsUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, void>> call({required TtsSettings params}) async {
    return settingsRepository.updateTtsSettings(params);
  }
}
