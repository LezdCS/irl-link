import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class SetSettingsUseCase implements UseCase<void, Settings> {
  final SettingsRepository settingsRepository;

  SetSettingsUseCase(this.settingsRepository);

  @override
  Future<void> call({required Settings params}) {
    return settingsRepository.setSettings(params);
  }
}
