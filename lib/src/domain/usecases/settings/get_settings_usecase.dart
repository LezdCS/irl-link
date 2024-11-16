import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class GetSettingsUseCase implements UseCase<DataState<Settings>, void> {
  final SettingsRepository settingsRepository;

  GetSettingsUseCase(this.settingsRepository);

  @override
  Future<DataState<Settings>> call({void params}) {
    return settingsRepository.getSettings();
  }
}
