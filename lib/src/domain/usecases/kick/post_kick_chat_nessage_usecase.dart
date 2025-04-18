import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/kick_repository.dart';

class PostKickChatMessageParams {
  final String accessToken;
  final String message;
  final int broadcasterUserId;
  const PostKickChatMessageParams({
    required this.accessToken,
    required this.message,
    required this.broadcasterUserId,
  });
}

class PostKickChatMessageUseCase
    implements UseCase<Either<Failure, void>, PostKickChatMessageParams> {
  final KickRepository repository;

  PostKickChatMessageUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call({
    required PostKickChatMessageParams params,
  }) {
    return repository.sendChatMessage(
      params,
    );
  }
}
