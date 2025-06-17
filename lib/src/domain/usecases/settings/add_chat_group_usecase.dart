import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class AddChatGroupUsecase implements UseCase<Either<Failure, void>, ChatGroup> {
  final SettingsRepository settingsRepository;

  AddChatGroupUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, void>> call({required ChatGroup params}) async {
    return settingsRepository.addChatGroup(params);
  }
}
