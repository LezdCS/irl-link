import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/settings/hidden_user.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class RemoveHiddenUserUseCase
    implements UseCase<Either<Failure, void>, HiddenUser> {
  final SettingsRepository settingsRepository;

  RemoveHiddenUserUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, void>> call({required HiddenUser params}) async {
    return settingsRepository.removeHiddenUser(params);
  }
}
