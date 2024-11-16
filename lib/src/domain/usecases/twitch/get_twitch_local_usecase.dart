import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class GetTwitchLocalUseCase
    implements UseCase<DataState<TwitchCredentials>, void> {
  final TwitchRepository twitchRepository;

  GetTwitchLocalUseCase(this.twitchRepository);

  @override
  Future<DataState<TwitchCredentials>> call({void params}) {
    return twitchRepository.getTwitchFromLocal();
  }
}
