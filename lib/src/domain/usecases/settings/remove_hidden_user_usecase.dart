import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/domain/entities/settings/hidden_user.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class RemoveHiddenUserUseCase {
  final SettingsRepository settingsRepository;

  RemoveHiddenUserUseCase({required this.settingsRepository});

  Future<Either<Failure, void>> call(HiddenUser hiddenUser) async {
    return settingsRepository.removeHiddenUser(hiddenUser);
  }
}
