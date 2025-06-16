import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings/hidden_user.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class GetHiddenUsersUseCase
    implements UseCase<Either<Failure, List<HiddenUser>>, void> {
  final SettingsRepository settingsRepository;

  GetHiddenUsersUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<HiddenUser>>> call({void params}) async {
    return settingsRepository.getHiddenUsers();
  }
}
