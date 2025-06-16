import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class GetChatGroupsUsecase
    implements UseCase<Either<Failure, List<ChatGroup>>, void> {
  final SettingsRepository settingsRepository;

  GetChatGroupsUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<ChatGroup>>> call({required void params}) async {
    return settingsRepository.getChatGroups();
  }
}
