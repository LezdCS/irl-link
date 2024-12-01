import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_user.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class GetTwitchUserUseCaseParams {
  final String? username;
  final String accessToken;

  GetTwitchUserUseCaseParams({this.username, required this.accessToken});
}

class GetTwitchUserUseCase
    implements
        UseCase<Either<Failure, TwitchUser>, GetTwitchUserUseCaseParams> {
  final TwitchRepository twitchRepository;

  GetTwitchUserUseCase(this.twitchRepository);

  @override
  Future<Either<Failure, TwitchUser>> call({
    required GetTwitchUserUseCaseParams params,
  }) {
    return twitchRepository.getTwitchUser(params.username, params.accessToken);
  }
}
