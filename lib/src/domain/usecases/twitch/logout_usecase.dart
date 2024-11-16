import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class LogoutUseCase implements UseCase<DataState<String>, String> {
  final TwitchRepository twitchRepository;

  LogoutUseCase(this.twitchRepository);

  @override
  Future<DataState<String>> call({
    required String params,
  }) {
    return twitchRepository.logout(params);
  }
}
