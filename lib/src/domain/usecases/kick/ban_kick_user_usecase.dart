import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/kick_repository.dart';

class BanKickUserParams {
  final String accessToken;
  final String broadcasterUserId;
  final String userToBanId;
  final String? reason;
  final int? duration;

  const BanKickUserParams({
    required this.accessToken,
    required this.broadcasterUserId,
    required this.userToBanId,
    this.reason,
    this.duration,
  });
}

class BanKickUserUseCase
    implements UseCase<Either<Failure, void>, BanKickUserParams> {
  final KickRepository repository;

  BanKickUserUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call({
    required BanKickUserParams params,
  }) {
    return repository.banUser(
      params: params,
    );
  }
}
