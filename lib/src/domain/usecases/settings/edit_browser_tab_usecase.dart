import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class EditBrowserTabUsecase
    implements UseCase<Either<Failure, void>, BrowserTab> {
  final SettingsRepository settingsRepository;

  EditBrowserTabUsecase(this.settingsRepository);

  @override
  Future<Either<Failure, void>> call({required BrowserTab params}) async {
    return settingsRepository.editBrowserTab(params);
  }
}
