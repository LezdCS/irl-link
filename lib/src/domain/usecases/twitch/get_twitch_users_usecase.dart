import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_user.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class GetTwitchUsersUseCaseParams {
  final List ids;
  final String accessToken;

  GetTwitchUsersUseCaseParams({
    required this.ids,
    required this.accessToken,
  });
}

class GetTwitchUsersUseCase
    implements
        UseCase<Either<Failure, List<TwitchUser>>,
            GetTwitchUsersUseCaseParams> {
  final TwitchRepository twitchRepository;

  GetTwitchUsersUseCase(this.twitchRepository);

  @override
  Future<Either<Failure, List<TwitchUser>>> call({
    required GetTwitchUsersUseCaseParams params,
  }) {
    return twitchRepository.getTwitchUsers(params.ids, params.accessToken);
  }
}
