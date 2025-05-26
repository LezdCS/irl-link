import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/kick_repository.dart';

class UnbanKickUserParams {
  final String accessToken;
  final String broadcasterUserId;
  final String userToUnbanId;

  const UnbanKickUserParams({
    required this.accessToken,
    required this.broadcasterUserId,
    required this.userToUnbanId,
  });
}

class UnbanKickUserUseCase
    implements UseCase<Either<Failure, void>, UnbanKickUserParams> {
  final KickRepository repository;

  UnbanKickUserUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call({
    required UnbanKickUserParams params,
  }) {
    return repository.unbanUser(
      params: params,
    );
  }
}
