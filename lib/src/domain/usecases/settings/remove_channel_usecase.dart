import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class RemoveChannelUsecase
    implements UseCase<Either<Failure, void>, (ChatGroup, Channel)> {
  final SettingsRepository settingsRepository;

  RemoveChannelUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, void>> call(
      {required (ChatGroup, Channel) params,}) async {
    return settingsRepository.removeChannel(params.$1, params.$2);
  }
}
