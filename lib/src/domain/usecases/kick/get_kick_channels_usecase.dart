import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/kick/kick_channel.dart';
import 'package:irllink/src/domain/repositories/kick_repository.dart';

class GetKickChannelsUseCase
    implements UseCase<Either<Failure, List<KickChannel>>, String> {
  final KickRepository kickRepository;

  GetKickChannelsUseCase(this.kickRepository);

  @override
  Future<Either<Failure, List<KickChannel>>> call({
    required String params,
  }) {
    return kickRepository.getChannels(
      accessToken: params,
    );
  }
}
