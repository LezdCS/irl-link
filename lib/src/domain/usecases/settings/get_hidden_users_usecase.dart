import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/domain/entities/settings/hidden_user.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class GetHiddenUsersUseCase {
  final SettingsRepository settingsRepository;

  GetHiddenUsersUseCase({required this.settingsRepository});

  Future<Either<Failure, List<HiddenUser>>> call() async {
    return settingsRepository.getHiddenUsers();
  }
}
