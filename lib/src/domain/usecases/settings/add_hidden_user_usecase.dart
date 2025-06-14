import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/domain/entities/settings/hidden_user.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class AddHiddenUserUseCase {
  final SettingsRepository settingsRepository;

  AddHiddenUserUseCase({required this.settingsRepository});

  Future<Either<Failure, void>> call(HiddenUser hiddenUser) async {
    return settingsRepository.addHiddenUser(hiddenUser);
  }
}
