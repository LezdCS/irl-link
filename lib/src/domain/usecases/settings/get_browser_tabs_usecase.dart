import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class GetBrowserTabsUsecase
    implements UseCase<Either<Failure, List<BrowserTab>>, void> {
  final SettingsRepository settingsRepository;

  GetBrowserTabsUsecase(this.settingsRepository);

  @override
  Future<Either<Failure, List<BrowserTab>>> call({
    required void params,
  }) async {
    return settingsRepository.getBrowserTabs();
  }
}
