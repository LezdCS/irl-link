import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/kick/kick_channel.dart';
import 'package:irllink/src/domain/repositories/kick_repository.dart';

class PatchKickChannelParams {
  final String accessToken;
  final String streamTitle;
  final String categoryId;

  PatchKickChannelParams({
    required this.accessToken,
    required this.streamTitle,
    required this.categoryId,
  });
}

class PatchKickChannelUseCase
    implements UseCase<Either<Failure, KickChannel>, PatchKickChannelParams> {
  final KickRepository kickRepository;

  PatchKickChannelUseCase(this.kickRepository);

  @override
  Future<Either<Failure, KickChannel>> call({
    required PatchKickChannelParams params,
  }) {
    return kickRepository.patchChannel(
      params,
    );
  }
}
